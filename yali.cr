alias Num = Int32 | Float64
alias Expression = Num | Symbol | Array(Expression)


class Env
  def initialize(@env=[] of Tuple(Symbol, Num | Closure))
  end

  def setenv(x : Symbol, v : Num | Closure)
    return [{x, v}] + @env as Array({Symbol, Num | Closure})
  end

  def lookup(x : Symbol)
    @env.each do |p|
      if p[0] == x
        return p[1]
      end
    end
    raise "not defined"
  end
end


struct Closure
  property exp, env
  def initialize(@exp : Expression, @env : Env)
  end
end


def interpreter(exp : Expression, env=Env.new)
  case exp
  when Num
    return exp
  when Symbol
    return env.lookup(exp)
  when Array
    f, e1 = exp
    case f
    when :lambda
      return Closure.new(exp, env)
    when :let
      if e1.is_a?(Array)
        pair = e1[0]
        if pair.is_a?(Array)
          x, e = pair[0] as Symbol, pair[1]
          v1 = interpreter(e, env) as Num | Closure
          interpreter(exp[2], Env.new(env.setenv(x, v1)))
        end
      end
    else
      case exp.size
      when 2
        v1, v2 = interpreter(f, env), interpreter(e1, env)
        if v1.is_a?(Closure)
          exp = v1.exp as Array(Expression)
          x = exp[1] as Array(Expression)
          if !v2.nil?
            interpreter(exp[2], Env.new(v1.env.setenv(x[0] as Symbol, v2 as Num)))
          end
        end
      else
        op, v1, v2 = f, interpreter(e1, env) as Num, interpreter(exp[2], env) as Num
        case op
        when :+
          return v1 + v2
        when :-
          return v1 - v2
        when :*
          return v1 * v2
        when :/
          return v1 / v2
        end
      end
    end
  else
    raise "syntax error"
  end
end
