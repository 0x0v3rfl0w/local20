


/datum/cargo_quests_storage
	/// List of purchase order categories.
	var/list/current_quests = list()
	///	Difficultly of task, datum
	var/datum/quest_difficulty/quest_difficulty
	/// If current quest storage is active, we will check it when the cargo shuttle is moving.
	var/active = FALSE
	/// The time it takes to complete this.
	var/quest_time = -1
	/// The time when it appeared.
	var/time_start
	/// Bonus for quick execution, if FALSE, then there is no bonus.
	var/fast_failed = FALSE
	/// Order customer, this distributes orders to different tabs in the console.
	var/datum/quest_customer/customer

	/// The timer, when it expires, we will not receive a bonus for fast delivery.
	var/fast_check_timer
	/// The timer, when it expires, we will fail the quest.
	var/quest_check_timer

	/// Reward for quest.
	var/reward
	/// Name of the person who accepted the order.
	var/idname = "*None Provided*"
	/// Name of the person who accepted the order.
	var/idrank = "*None Provided*"
	///	If TRUE we can reroll this quest.
	var/can_reroll = TRUE
	/// Date when the order was accepted
	var/order_date
	/// Time when the order was accepted
	var/order_time

/datum/cargo_quests_storage/proc/generate()
	if(!quest_difficulty)
		quest_difficulty = customer.get_difficulty()
	if(!quest_difficulty)
		quest_difficulty = pickweight(SScargo_quests.difficulties)
	quest_difficulty.generate_timer(src)
	for(var/I in 1 to rand(2,4))
		var/datum/cargo_quest/cargo_quest = add_quest()
		if(cargo_quest)
			current_quests += cargo_quest

	if(GLOB.security_level > SEC_LEVEL_RED)
		reward *= 2
	customer.change_reward(src)
	customer.special(src)

/datum/cargo_quests_storage/proc/add_quest(quest_type)

	if(length(customer.can_order))
		quest_type = pick(customer.can_order)


	if(!quest_type)
		var/list/possible_types = list()
		for(var/path in subtypesof(/datum/cargo_quest) - /datum/cargo_quest/thing)
			var/datum/cargo_quest/cargo_quest = path
			if(!(initial(cargo_quest.difficultly_flags) & quest_difficulty.diff_flag))
				continue
			possible_types += path
		possible_types.Remove(customer.cant_order)
		quest_type = pick(possible_types)

	for(var/datum/cargo_quest/quest in current_quests)
		if(quest.type != quest_type)
			continue
		quest.generate_goal(difficultly = quest_difficulty.diff_flag)
		quest.update_interface_icon()
		return

	return new quest_type(src)


/datum/cargo_quests_storage/proc/after_activated()
	if(!fast_check_timer)
		return
	if(world.time - time_start - 0.4 * quest_time + 120 SECONDS >= 0)
		deltimer(fast_check_timer)
		fast_check_timer = addtimer(VARSET_CALLBACK(src, fast_failed, TRUE), 120 SECONDS, TIMER_STOPPABLE)

/datum/cargo_quests_storage/proc/check_quest_completion(obj/structure/bigDelivery/closet)
	if(!istype(closet) || !istype(closet.wrapped, /obj/structure/closet/crate))
		return FALSE

	if(!length(closet.wrapped.contents))
		return FALSE

	var/req_quantity = 0
	for(var/datum/cargo_quest/quest in current_quests)
		req_quantity += quest.length_quest()

	var/extra_items = 0
	var/contents_length = length(closet.wrapped.contents)
	for(var/atom/movable/item in closet.wrapped.contents)
		var/has_extra_item = TRUE
		for(var/datum/cargo_quest/quest in current_quests)
			if(!is_type_in_list(item, quest.req_items))
				continue
			if(quest.check_required_item(item))
				has_extra_item = FALSE
				break

		if(has_extra_item)
			extra_items++
			continue

		req_quantity--

	if(extra_items == contents_length)
		return FALSE

	var/failed_quest_length
	for(var/datum/cargo_quest/quest in current_quests)
		failed_quest_length += quest.length_quest()

	var/old_reward = reward
	var/list/modificators = list()

	if(closet.cc_tag != customer.departament_name)
		reward -= old_reward * 0.2
		modificators["departure_mismatch"] = TRUE

	if(extra_items)
		reward -= old_reward * 0.3 * extra_items
		modificators["content_mismatch"] = extra_items

	if(req_quantity < 0)
		reward -= old_reward * -0.3 * req_quantity
		modificators["content_mismatch"] += -req_quantity

	if(failed_quest_length)
		reward -= old_reward * 0.5 * failed_quest_length
		modificators["content_missing"] = failed_quest_length

	if(!failed_quest_length && !fast_failed)
		reward += old_reward * 0.4
		modificators["quick_shipment"] = TRUE
		if(closet.cc_tag == customer.departament_name)
			customer.set_sale()

	if(reward <= 0)
		reward = 1

	reward = round(reward)
	SScargo_quests.remove_quest(UID(), complete = TRUE, modificators = modificators, old_reward = old_reward)

	return reward

/datum/cargo_quest
	/// Quest name, using in interface.
	var/quest_type_name = "generic"
	/// Link to the storage.
	var/datum/cargo_quests_storage/q_storage
	/// Quest desc, using in interface.
	var/list/desc = list()
	/// Quest interface icons, using in interface.
	var/list/interface_icons = list()
	/// Quest interface icon states, using in interface.
	var/list/interface_icon_states = list()
	/// Requested order's item types, unless otherwise specified.
	var/list/req_items = list()
	///possible difficultly
	var/difficultly_flags


/datum/cargo_quest/New(storage)
	q_storage = storage
	generate_goal(difficultly = q_storage.quest_difficulty.diff_flag)
	update_interface_icon()

/datum/cargo_quest/proc/generate_goal(difficultly)
	return

/datum/cargo_quest/proc/length_quest()
	return

/datum/cargo_quest/proc/update_interface_icon()
	return


/datum/cargo_quest/proc/check_required_item(atom/movable/check_item)
	return

