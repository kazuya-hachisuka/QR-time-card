Admin.seed do |s|
	s.id = 1
	s.family_name = "勤怠"
	s.given_name = "管理"
	s.family_name_kana = "キンタイ"
	s.given_name_kana = "カンリ"
	s.email = "1@1"
	s.password = "password"
	s.is_main_administer = "true"
end

Admin.seed do |s|
	s.id = 2
	s.family_name = "サブ"
	s.given_name = "管理"
	s.family_name_kana = "サブ"
	s.given_name_kana = "カンリ"
	s.email = "2@2"
	s.password = "password"
	s.is_main_administer = "false"
end
