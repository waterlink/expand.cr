macro a
  "a macro"
end

macro b
  a
  "b macro"
end

macro c
  b
  a
  "c macro"
end

c
