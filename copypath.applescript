on open these_items
	set myItems to itemSort(these_items) -- v1.0.5 ASCIIsort failed on older versions of applescript. -- CBT; 10/5/99
	
	set path_str to "" as string
	
	repeat with i from 1 to the count of myItems
		set this_item to item i of myItems
		set posix_path to POSIX path of this_item
		
		-- For now I'm stripping the preceding '/Volumes' string for external 
		-- drives so I don't clutter my build logs.
		set shortened_path to do shell script "
			echo \"" & posix_path & "\" | sed 's|/Volumes||'
		"
		set path_str to path_str & shortened_path & return
		--set path_str to path_str & posix_path & return
	end repeat
	
	-- Copy plain text to the clipboard.
	set the clipboard to «class ktxt» of ((the path_str as text) as record)
end open

on itemSort(my_list)
	set the index_list to {}
	set the sorted_list to {}
	repeat (the number of items in my_list) times
		set the low_item to ""
		repeat with i from 1 to (number of items in my_list)
			if i is not in the index_list then
				set this_item to item i of my_list
				if the low_item as text is "" then
					set the low_item to this_item
					set the low_item_index to i
				else if this_item as text comes before the low_item as text then
					set the low_item to this_item
					set the low_item_index to i
				end if
			end if
		end repeat
		set the end of sorted_list to the low_item
		set the end of the index_list to the low_item_index
	end repeat
	return the sorted_list
end itemSort
