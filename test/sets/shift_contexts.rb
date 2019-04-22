module Contexts
  module ShiftContexts
    def create_shifts
      create_upcoming_shifts
      create_past_shifts
    end

    def remove_shifts
      remove_upcoming_shifts
      remove_past_shifts
    end

    def create_upcoming_shifts
      @assign_ed_1    = FactoryBot.create(:assignment, employee: @ed, store: @cmu, start_date: 1.month.ago.to_date, end_date: nil, pay_level: 2)
      @ed_shift1      = FactoryBot.create(:shift, assignment: @assign_ed_1)
      @ed_shift2      = FactoryBot.create(:shift, assignment: @assign_ed_1, date: 1.day.from_now.to_date)
      @ed_shift3      = FactoryBot.create(:shift, assignment: @assign_ed_1, date: 2.days.from_now.to_date)
      @ben_shift1     = FactoryBot.create(:shift, assignment: @promote_ben)
      @ben_shift2     = FactoryBot.create(:shift, assignment: @promote_ben, date: 1.day.from_now.to_date)
      @kathryn_shift1 = FactoryBot.create(:shift, assignment: @assign_kathryn)
      @cindy_shift1   = FactoryBot.create(:shift, assignment: @assign_cindy, date: 2.days.from_now.to_date)
    end

    def remove_upcoming_shifts
      @assign_ed_1.destroy
      @ed_shift1.destroy     
      @ed_shift2.destroy
      @ed_shift3.destroy
      @ben_shift1.destroy
      @ben_shift2.destroy
      @kathryn_shift1.destroy
      @cindy_shift1.destroy
    end

    def create_past_shifts
      @assign_ed_2  = FactoryBot.create(:assignment, employee: @ed, store: @cmu, start_date: 1.month.ago.to_date, end_date: nil, pay_level: 2)
      @ed_past_shift1 = FactoryBot.create(:shift, assignment: @assign_ed_2, date: 1.week.from_now.to_date)
      @ed_past_shift1.update_attribute(:date, 1.day.ago.to_date)
      @ed_past_shift2 = FactoryBot.create(:shift, assignment: @assign_ed_2, date: 1.week.from_now.to_date)
      @ed_past_shift2.update_attribute(:date, 2.days.ago.to_date)
      @ed_past_shift3 = FactoryBot.create(:shift, assignment: @assign_ed_2, date: 1.week.from_now.to_date)
      @ed_past_shift3.update_attribute(:date, 3.days.ago.to_date)
      @kathryn_past_shift1 = FactoryBot.create(:shift, assignment: @assign_kathryn, date: 1.week.from_now.to_date)
      @kathryn_past_shift1.update_attribute(:date, 1.day.ago.to_date)
    end

    def remove_past_shifts
      @assign_ed_2.destroy
      @ed_past_shift1.destroy
      @ed_past_shift2.destroy
      @ed_past_shift3.destroy
      @kathryn_past_shift1.destroy
    end

  end
  end