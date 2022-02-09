-- pa2.lua
-- Millard A. Arnold V
-- 2022-02-08
--
-- For CS F331 Spring 2022
-- Answer to Assignment 2 Exercise 2

local pa2 = {}

function pa2.mapTable(f, t)
  for key, value in pairs(t) do t[key] = f(value) end
  return t
end

function pa2.concatMax(s, i)
  n = ""
  while string.len(n) <= (i-string.len(s)) do
    n = n .. s
  end
  return n
end

function pa2.collatz(k)
  local currk = k, 1
  function iter(dummy1)
    if currk == 0 then 
      return nil 
    end
    local savek = currk
    if currk == 1 then 
      currk = 0 
    end
    if currk % 2 == 1 then 
      currk = 3 * currk + 1
    else 
      currk = currk/2 
    end
    return savek
  end
  return iter, nil
end

function pa2.backSubs(s)
  coroutine.yield("")
  s = string.reverse(s)
  for l = 0, string.len(s), 1 do
    for i = 1, string.len(s)-l, 1 do
      coroutine.yield(string.sub(s,i,i+l))
    end
  end
  return s
end

return pa2