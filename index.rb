
def max_number(nums1, nums2, k)
  best = []

  min_take = [0, k - nums2.length].max
  max_take = [k, nums1.length].min

  (min_take..max_take).each do |i|
    j = k - i

    part1 = max_subsequence(nums1, i)
    part2 = max_subsequence(nums2, j)

    candidate = merge(part1, part2)

    best = candidate if (candidate <=> best) == 1
  end

  best
end

def max_subsequence(nums, k)
  stack = []
  drop = nums.length - k

  nums.each do |num|
    while !stack.empty? && drop > 0 && stack[-1] < num
      stack.pop
      drop -= 1
    end

    stack << num
  end

  stack.take(k)
end

def merge(nums1, nums2)
  result = []
  i = 0
  j = 0

  while i < nums1.length || j < nums2.length
    if greater?(nums1, i, nums2, j)
      result << nums1[i]
      i += 1
    else
      result << nums2[j]
      j += 1
    end
  end

  result
end

def greater?(nums1, i, nums2, j)
  while i < nums1.length && j < nums2.length
    if nums1[i] != nums2[j]
      return nums1[i] > nums2[j]
    end

    i += 1
    j += 1
  end

  i < nums1.length
end
