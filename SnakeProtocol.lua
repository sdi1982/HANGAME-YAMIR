-- Protocol
Evt_UserStatus_Req = Event(1)-- 유저정보를 요청

Evt_UserStatus_Ack = Event(2)-- 유저정보와 맵정보를 받아옴
Evt_UserStatus_Ack.key =
{
	user1_id = 1,
	user1_exist = 2,
	user1_major = 3,
	user1_snake_kind = 4,
	user1_color = 5,
	user1_score = 6,
	user1_win = 7,
	user1_lose = 8,
	user1_draw = 9,
	user1_ready = 10,

	user2_id  = 11,
	user2_exist = 12,
	user2_major = 13,
	user2_snake_kind = 14,
	user2_color = 15,
	user2_score = 16,
	user2_win = 17,
	user2_lose = 18,
	user2_draw = 19,
	user2_ready = 20,

	user3_id  = 21,
	user3_exist = 22,
	user3_major = 23,
	user3_snake_kind = 24,
	user3_color = 25,
	user3_score = 26,
	user3_win = 27,
	user3_lose = 28,
	user3_draw = 29,
	user3_ready = 30,

	user4_id  = 31,
	user4_exist = 32,
	user4_major = 33,
	user4_snake_kind = 34,
	user4_color = 35,
	user4_score = 36,
	user4_win = 37,
	user4_lose = 38,
	user4_draw = 39,
	user4_ready = 40,

	user1_level = 41,		
	user2_level = 42,		
	user3_level = 43,		
	user4_level = 44,

	selected_map = 45,

	user1_snake_id = 46,
	user2_snake_id = 47,
	user3_snake_id = 48,
	user4_snake_id = 49
}

Evt_MapSelect_Req = Event(3) -- 수정된 맵정보를 보냄

Evt_MapSelect_Ack = Event(4)
Evt_MapSelect_Ack.key =
{
	selected_map = 1
}

Evt_Ready_Req = Event(5)

Evt_Exit_Req = Event(6)
Evt_Exit_Ack = Event(7)

Evt_Color_Req = Event(8)
Evt_Color_Req.key =
{
	color = 1
}

Evt_SnakeKind_Req = Event(9)
Evt_SnakeKind_Req.key =
{
	kind = 1
}

Evt_SnakeMove_Req = Event(10)
Evt_SnakeMove_Req.key =
{
	snake_id = 1,
	dir = 2,
	x = 3,
	y = 4
}

Evt_SnakeMove_Ack = Event(11)
Evt_SnakeMove_Ack.key =
{
	snake_id = 1,
	dir = 2,
	x = 3,
	y = 4,
	success = 5
}

Evt_SnakeAttack_Req = Event(12)
Evt_SnakeAttack_Req.key =
{
	snake_id = 1,
	dir = 2,
	x = 3,
	y = 4
}

Evt_SnakeAttack_Ack = Event(13)
Evt_SnakeAttack_Ack.key =
{
	snake_id = 1,
	attack_dir = 2
}

Evt_ChangeWall_Ack = Event(14)
Evt_ChangeWall_Ack.key =
{
	wall_i = 1,
	wall_j = 2,
	wall_index = 3
}

Evt_SnakeSuffer_Ack = Event(15)
Evt_SnakeSuffer_Ack.key =
{
	snake_id = 1,
	state = 2
}

Evt_UserMajor_Req = Event(16)
Evt_UserMajor_Req.key =
{
	user_id = 1
}

Evt_GameStart_Ack = Event(17)

Evt_GameOver_Ack = Event(18)
Evt_GameOver_Ack.key =
{
	winner_user_id = 1
}

Evt_Time_Ack = Event(19)
Evt_Time_Ack.key =
{
	time = 1
}

Evt_CreateItem_Ack = Event(20)
Evt_CreateItem_Ack.key =
{
	kind = 1,
	i = 2,
	j = 3
}

Evt_UseItem_Ack = Event(21)
Evt_UseItem_Ack.key =
{
	snake_id = 1,
	kind = 2,
	i = 3,
	j = 4
}
