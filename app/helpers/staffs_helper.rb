module StaffsHelper
def midnight(work_in,work_out)
			work_5 = work_in.to_date
			work_5 = work_5.to_s + " 5:00:00"
			work_5 = work_5.in_time_zone

			work_0 = work_in.to_date
			work_0 = work_0.to_s + " 00:00:00"
			work_0 = work_0.in_time_zone
	#mid_inにwork.inの次の日の00:00を入れる
			work_24 = work_in.to_date
			work_24 = work_24.to_s + " 00:00:00"
			work_24 = work_24.in_time_zone.tomorrow

			#mid_outにwork.inの次の日の5:00を入れる
			work_29 = work_in.to_date
			work_29 = work_29.to_s + " 5:00:00"
			work_29 = work_29.in_time_zone.tomorrow

			#mid_inにwork.inの22:00を入れる
			work_22 = work_in.to_date
			work_22 = work_22.to_s + " 22:00:00"
			work_22 = work_22.in_time_zone

			work_46 = work_out.to_date
			work_46 = work_46.to_s + " 22:00:00"
			work_46 = work_46.in_time_zone

			work_48 = work_out.to_date
			work_48 = work_48.to_s + " 00:00:00"
			work_48 = work_48.in_time_zone.tomorrow

			midnight_a = work_0..work_5
			midnight_b = work_22..work_24
			midnight_c = work_24..work_29
			midnight_d = work_46..work_48

		midnight_work = 0

	# 出勤と退勤が同じ日付の場合
	if work_in.strftime('%Y/%m/%d') == work_out.strftime('%Y/%m/%d')

		# 出勤が00時−05時に含まれるか
		if midnight_a.cover?(work_in)
			# 退勤が00時ー05時に含まれるか
			if midnight_a.cover?(work_out)
				midnight_work = work_out.in_time_zone - work_in.in_time_zone
				return midnight_work
			# 退勤が22時ー24時に含まれるか
			elsif midnight_b.cover?(work_out)
				midnight_work = work_5.in_time_zone - work_in.in_time_zone
				midnight_work += work_out.in_time_zone - work_22.in_time_zone
				return midnight_work
			# それ以外(退勤が05時ー22時)
			else
				midnight_work = work_5.in_time_zone - work_in.in_time_zone
				return midnight_work
			end
		# 出勤が22時ー24時に含まれるか
		elsif midnight_b.cover?(work_in)
			midnight_work = work_out.in_time_zone - work_in.in_time_zone
			return midnight_work
		# それ以外(出勤が5時ー22時)
		else
			# 退勤が22時ー24時に含まれるか
			if midnight_b.cover?(work_out)
				midnight_work += work_out.in_time_zone - work_22.in_time_zone
				return midnight_work
			# それ以外（退勤が -22時）
			else
				return midnight_work
			end
		end

	else

		#　出勤が00時−05時に含まれるか
		if midnight_a.cover?(work_in)
			midnight_work += work_5.in_time_zone - work_in.in_time_zone

			# 退勤が24時-29時に含まれるか
			if midnight_c.cover?(work_out)
				midnight_work += work_out.in_time_zone - work_22.in_time_zone

				# 退勤が46時~48時に含まれるか
			elsif midnight_d.cover?(work_out)
					midnight_work += work_29.in_time_zone - work_22.in_time_zone
					midnight_work += work_out.in_time_zone - work_46.in_time_zone

			else
					midnight_work += work_29.in_time_zone - work_22.in_time_zone
			end
				return midnight_work

		# 出勤が22時~24時に含まれるか
		elsif midnight_b.cover?(work_in)
			# 退勤が24時~05時に含まれるか
			if midnight_c.cover(work_out)
				midnight_work = work_out.in_time_zone - work_in.in_time_zone

				# 退勤が46時~48時に含まれるか
			elsif midnight_d.cover(work_out)
					midnight_work = work_29.in_time_zone - work_in.in_time_zone
					midnight_work += work_out.in_time_zone - work_46.in_time_zone
			else
					midnight_work = work_29.in_time_zone - work_in.in_time_zone
			end
					return midnight_work

		else
			# 退勤が24時~05時に含まれているか
			if midnight_c.cover?(work_out)
				midnight_time = work_out.in_time_zone - work_22.in_time_zone

			# 退勤が46時~48時に含まれるか
			elsif midnight_d.cover?(work_out)
				midnight_time = work_29.in_time_zone - work_22.in_time_zone
				midnight_time += work_out.in_time_zone - work_46.in_time_zone
			else
				midnight_time = work_29.in_time_zone - work_22.in_time_zone
			end
				return midnight_time
		end
	end
end






	# def midnight_time
	# 	#work.inとwork.outが同じか？
	# 	if @work.in.strftime('%Y年%m月%d日') == @work.out.strftime('%Y年%m月%d日')
	# 		#mid_inにwork.inの次の日の00:00を入れる
	# 		work_24 = work_in.to_date
	# 		work_24 = work_24.to_s + " 00:00:00"
	# 		work_24 = work_24.in_time_zone.tomorrow

	# 		#mid_outにwork.inの次の日の5:00を入れる
	# 		work_29 = @work.in_to_date
	# 		work_29 = work_29.to.s + " 5:00:00"
	# 		work_29 = work_29.in_time_zone.tomorrow

	# 		#mid_inにwork.inの22:00を入れる
	# 		work_22 = @work.in_to_date
	# 		work_22 = work_22.to.s + " 22:00:00"
	# 		work_22 = work_22.in_time_zone

	# 		#mid_outにwork.inの00:00を入れる
	# 		work_48 = @work.out_to_date
	# 		work_48 = work_48.to.s + " 00:00:00"
	# 		work_48 = work_48.in_time_zone.tomorrow


	# 		#0:00~5:00にwork.inが含まれるか？
	# 		if (mid_in_a..mid_out_a).cover?(@work.in)

	# 			#work.outが0:00~5:00に含まれるか？
	# 			if (mid_in_a..mid_out_a).cover?(@work.out)

	# 				midnight_time = @work.out_time_zone - @work.in.in_time_zone

	# 			elsif (mid_in_b..mid_out_b).cover?(@work.out)

	# 				midnight_time = work_out_

	# 		else
	# 			#mid_inが22:00
	# 			mid_in = @work.in.to_date
	# 			mid_in = mid_in.to_s + " 22:00:00"

	# 			#mid_outが00:00
	# 			mid_out = @work.in_to_date
	# 			mid_out = mid_out.to_s + " 00:00:00"
	# 			mid_out = mid_out.in_time_zone.tomorrow

	# 			#22:00~00:00にwork_inが含まれるか？
	# 			if (mid_in..mid_out).cover?(@work.in)
	# 				#含まれればすべて深夜時間での勤務
	# 				@midnight = @work.out.in_time_zone - @work.in.in_time_zone
	# 			else
	# 					#22:00~00:00にwork.outが含まれているか？
	# 				if (mid_in..mid_out).cover?(@work.out)
	# 					#22:00~work.outが深夜時間
	# 					midnight_time = @work.out.in_time_zone - mid_in.in_time_zone

	# 				else
	# 					midnight_time = 0
	# 				end
	# 			end
	# 					return midnight_time
	# end

end
