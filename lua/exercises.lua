function change(amount)
  if math.type(amount) ~= "integer" then
    error("Amount must be an integer")
  end
  if amount < 0 then
    error("Amount cannot be negative")
  end
  local counts, remaining = {}, amount
  for _, denomination in ipairs({25, 10, 5, 1}) do
    counts[denomination] = remaining // denomination
    remaining = remaining % denomination
  end
  return counts
end

-- Write your first then lower case function here
function first_then_lower_case(strings, predicate)
  for i = 0, #strings do
    if strings[i] ~= nil and predicate(strings[i]) then
      return string.lower(strings[i])
    end
  end
  return nil
end

-- Write your powers generator here
function powers_generator(base, limit)
  local power = 1
  return coroutine.create(function()
    while power <= limit do
      coroutine.yield(power)
      power = power * base
    end
  end)
end


-- Write your say function here
function say(word)
  local str = {}

  function chain(next)
    if next ~= nil then
      table.insert(str, next)
      return chain
    else
      return table.concat(str, " ")
    end
  end

  if word == nil then
    return ""
  end
  table.insert(str, word)
  return chain
  
end


-- Write your line count function here
-- used http://lua-users.org/wiki/StringTrim to help me trim the whitespace
function meaningful_line_count(filename)
  local file = io.open(filename, "r")
  count = 0
  if file == nil then
    error("No such file")
  end
  
  for line in file:lines() do
    trimmedLine = line:gsub("^%s*(.-)%s*$", "%1") 

    if(trimmedLine ~= "" and not trimmedLine:match("^#")) then
      count = count + 1
    end
  end

  file:close()
  return count
end


Quaternion = {}
Quaternion.__index = Quaternion

function Quaternion.new(a, b, c, d)
  local self = setmetatable({}, Quaternion)
  self.a = a
  self.b = b
  self.c = c
  self.d = d
  return self
end

function Quaternion:coefficients()
  return {self.a, self.b, self.c, self.d}
end

function Quaternion:conjugate()
  return Quaternion.new(self.a, -self.b, -self.c, -self.d)
end

function Quaternion:__add(q)
  return Quaternion.new(
    self.a + q.a,
    self.b + q.b,
    self.c + q.c,
    self.d + q.d
  )
end

function Quaternion:__mul(q)
  return Quaternion.new(
    self.a * q.a - self.b * q.b - self.c * q.c - self.d * q.d,
    self.a * q.b + self.b * q.a + self.c * q.d - self.d * q.c,
    self.a * q.c - self.b * q.d + self.c * q.a + self.d * q.b,
    self.a * q.d + self.b * q.c - self.c * q.b + self.d * q.a
  )
end

function Quaternion:__eq(q)
  return self.a == q.a and self.b == q.b and self.c == q.c and self.d == q.d
end

function Quaternion:__tostring()
  local str = ""

  if self.a ~= 0 then
    str = tostring(self.a)
  end

  if self.b ~= 0 then
    if self.b == 1 then
      if str == "" then
        str = "i"
      else
        str = str .. "+i"
      end
    elseif self.b == -1 then
      str = str .. "-i"
    elseif self.b > 0 then
      str = str .. "+" .. tostring(self.b) .. "i"
    else 
      str = str .. tostring(self.b) .. "i"
    end
  end

  if self.c ~= 0 then
    if self.c == 1 then
      if str == "" then
        str = "j"
      else
        str = str .. "+j"
      end
    elseif self.c == -1 then
      str = str .. "-j"
    elseif self.c > 0 then
      str = str .. "+" .. tostring(self.c) .. "j"
    else 
      str = str .. tostring(self.c) .. "j"
    end
  end

  if self.d ~= 0 then
    if self.d == 1 then
      if str == "" then
        str = "k"
      else
        str = str .. "+k"
      end
    elseif self.d == -1 then
      str = str .. "-k"
    elseif self.d > 0 then
      str = str .. "+" .. tostring(self.d) .. "k"
    else 
      str = str .. tostring(self.d) .. "k"
    end
  end

  if str == "" then
    str = "0"
  end

  return str

end
