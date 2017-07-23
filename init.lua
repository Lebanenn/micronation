local function passport_on_use(itemstack, player, pointed_thing)
	local meta = itemstack:get_meta()
	local old_data = minetest.deserialize(itemstack:get_metadata())
	if old_data then
		meta:from_table({ fields = old_data })
	end

	local data = meta:to_table().fields

	local passport_formspec =
	"size[12,7]"..
	"background[12,7;1,1;micronation_passport_blank.png;true]"..
	"size[6,10]"..
	"label[0,0;Your passport]"..
	"label[0,1;"..data.name.."]"..
	"label[0,2;"..data.nat.."]"..
	"label[0,3;"..data.town.."]";

	minetest.show_formspec(player:get_player_name(),"passport_formspec", passport_formspec)

end

local function make_passport(itemstack, player, pointed_thing)
	local blank_passport_formspec=
	"size[12,7]"..
	"background[12,7;1,1;micronation_passport_blank.png;true]"..
	"label[0,0;Make your passport]"..
	"field[7,3;5,1;town;Town;Your Town]"..
	"field[7,2;5,1;nat;Nationality; Minetestien]"..
	"field[7,1;5,1;name;Name;"..player:get_player_name().."]"..
	"dropdown[0,4;1,1;color;Vert,Rouge,Jaune, Bleu, Orange, Marron;selected_id]"..
	"button_exit[8,6;2,1;btn_submit;Become citizen!]";

	minetest.show_formspec(player:get_player_name(),"blank_passport_formspec", blank_passport_formspec)

end

minetest.register_craftitem("micronation:blank_passport", {
	description = "Blank Passport",
	inventory_image = "default_book.png",
	stack_max = 1,
	on_place = make_passport,
})

minetest.register_craftitem("micronation:passport", {
	description = "Passport of citizen of minetest",
	--inventory_image = "default_book_written.png^minetest_logo.png",
	inventory_image = "default_book_written.png",
	stack_max = 1,
	on_place = passport_on_use,
})


minetest.register_on_joinplayer(function(player) -- a mettre on new player
  player:get_inventory():add_item("main", "micronation:blank_passport")
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "blank_passport_formspec" then
		if fields.btn_submit then
			local itemstack = player:get_wielded_item()
			local data = itemstack:get_meta():to_table().fields
			data.name= fields.name
			data.town=fields.town
			data.nat=fields.nat
			data.description = data.name.."\'s passport"
			itemstack:get_meta():from_table({fields = data})
			itemstack:set_name("micronation:passport")
			player:set_wielded_item(itemstack)
			minetest.chat_send_all(fields.color)
		end
	end
end)
