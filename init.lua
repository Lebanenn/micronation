local passport_formspec =
"size[6,10]"..
--"background[6,10;0,0;paper.png;auto_clip]"..
"bgcolor[#96926F]"..
"label[0,0;Welcome on minetest as a micronation.]"..
"field[1,3;4,1;field1;Name;Singleplayer]"..
"field[1,5;4,1;field2;Town;Lagoon city]"..
"field[1,7;4,1;field3;Double nationality;French]"..
"button[2,9;2,1;btn;Become Citizen !]";

minetest.register_craftitem("micronation:passport", {
	description = "Passport of citizen of minetest",
	inventory_image = "default_book_written.png^minetest_logo.png",
	on_use = function(itemstack, player, pointed_thing)
    minetest.show_formspec(player:get_player_name(),"passport_form", passport_formspec)
  end,
  on_receive_fields = function(pos, formname, fields, sender)
    --local stack = sender:get_inventory():get_stack("main",1)
    --stack:set_name("default:wood")
    minetest.chat_send_all("test")
  end,
  on_place = function(itemstack, placer, pointed_thing)
    minetest.chat_send_all("ECHO")
    local kesako=itemstack:get_name()
    minetest.chat_send_all(kesako)
    --itemstack:set_name("TEST")
    local mta = itemstack:get_metadata()
    minetest.chat_send_all(mta)
    itemstack:set_metadata("Je suis un livre")
    mta = itemstack:get_metadata()
    minetest.chat_send_all(mta)
  end
})


minetest.register_on_joinplayer(function(player) -- a mettre on nwe player
  player:get_inventory():add_item("main", "micronation:passport")
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	minetest.chat_send_all("Ou est ce ???")
	--minetest.chat_send_all(player:get_name())
	--if fields == "field2" then -- This is your form name
		--minetest.chat_send_all("Qui suis je ?")
	--end
end)
