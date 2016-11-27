function clear()
    begin
	   # Use system to process commands
	   run(@unix ? `clear` : `cmd /c cls`)
	end
end	