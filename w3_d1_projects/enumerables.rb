class Array

    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&prc)
        result = []
        self.my_each do |i|
            if prc.call(i)
                result << i
            end
        end
        result
    end

    def my_reject(&prc)
        self.my_select{|el| prc.call(el) == false}
    end

    def my_any?(&prc)
        return true if self.map {|el| el if prc.call(el) == true}.compact.length > 0
        false
    end

    def my_all?(&prc)
        return true if self.map {|el| el if prc.call(el) == true}.compact.length == self.length
        false
    end

    def flatten(arr)
        if arr.my_any?{|el| el.instance_of?(Array)} == true
            non_arrays  = arr.my_select{|el| el.instance_of?(Array) == false}
            arrays = arr.my_select{|el| el.instance_of?(Array) == true}
            arrays.each do |el| 
                if el.instance_of?(Array) == true
                    non_arrays.push(*el)
                else
                    non_arrays << el
                end
            end
            
            return flatten(non_arrays)
        else
            arr
        end
    end

    def my_flatten
        self.flatten(self).sort
    end

    def my_zip(*args)
        new_arr = [self, *args]
        result = []
        (0...self.length).each do |i|
            new_subarray = []
            new_arr.each do |subarray|
                new_subarray << subarray[i]
            end
            result << new_subarray
        end
        result
    end

    def my_rotate(num = 1)
        new_arr = self
        if num > 0
            num.times do 
                ele = new_arr.shift()
                new_arr.push(ele)  
            end
        else
            num = num.abs
            num.times do 
                ele = new_arr.pop
                new_arr.unshift(ele)
            end
        end
        new_arr
    end

    def my_join(sep='')
        result = ""
        self.each_with_index do |elem,i|
            if i < self.length - 1
                result += elem + sep
            else
                result += elem
            end
        end
        result
    end

    def my_reverse
        new_arr = []
        j = self.length-1
        while j >= 0
            new_arr << self[j]
            j -= 1
        end
        new_arr
    end
end