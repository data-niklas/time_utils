# TODO: Write documentation for `TimeUtils`
class Timer
  property at : Time | Time::Span, recurring : Bool, running : Bool, cancelled : Bool, block : Proc(Timer, Nil)

  def initialize(@at : Time | Time::Span, @recurring : Bool = false, &block : Timer -> _)
    raise "Recurring events may not be at a fixed point in time. A Time::Span is required" if @recurring && @at.is_a?(Time)
    @cancelled = false
    @block = block
    @running = false
  end

  def self.run(at : Time | Time::Span, recurring : Bool = false, &block : Timer -> _)
    timer = new(at, recurring, &block)
    timer.run
    timer    
  end

  def running?
    @running
  end

  def recurring?
    @recurring
  end

  def cancelled?
    @cancelled
  end

  def run
    raise "Timer can't run twice at the same time!" if @running
    @running = true
    spawn do
      point = nil
      loop do
        if @at.is_a?(Time)
          point = @at.as(Time)
        elsif point.nil?
          point = Time.utc + @at.as(Time::Span)
        else
          point += @at.as(Time::Span)
        end

        sleep({Time::Span.zero, point - Time.utc}.max)
        while point > Time.utc
          sleep({Time::Span.zero, point - Time.utc}.max)
        end

        if @cancelled || !@running
          @running = false
          break
        else
          @block.call self
          if !@recurring
            @running = false
            break
          end
        end

      end
    end
  end

  def cancel
    @cancelled = true
  end

  # THe currently running Fiber is NOT stopped!
  # The Proc will not be called anymore
  def stop
    @running = false
  end

end

def setTimeout(milliseconds : Int32, &block : Timer -> _)
  Timer.run(milliseconds.milliseconds, &block)
end

def set_timeout(milliseconds : Int32, &block : Timer -> _)
  Timer.run(milliseconds.milliseconds, &block)
end

def setInterval(milliseconds : Int32, &block : Timer -> _)
  Timer.run(milliseconds.milliseconds,true, &block)
end

def set_interval(milliseconds : Int32, &block : Timer -> _)
  Timer.run(milliseconds.milliseconds,true, &block)
end

def clearTimer(timer : Timer)
  timer.stop
end

def clear_timer(timer : Timer)
  timer.stop
end
