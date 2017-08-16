require 'spec_helper'
# Specs in this file have access to a helper object that includes
# the UnitsConverterHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end

RSpec.describe ManageIQ::Consumption::TimeConverterHelper, type: :helper do
  let(:constants) {
    [ManageIQ::Consumption::TimeConverterHelper::VALID_INTERVAL_UNITS]
  }
  context 'CONSTANTS' do
    it 'symbols should be constant' do
      constants.each do |x|
        expect(x).to be_frozen
      end
    end
  end

  context '#number of intervals on this month' do
    let(:time_values) { [0.seconds, 15.minutes, 45.minutes, 1.hour, 90.minutes, 5.hours, 1.day, (1.5).days, 1.week, (1.4).weeks, 1.month] }

    it 'hourly' do
      interval = 'hourly'
      results = [1, 1, 1, 1, 2, 5, 24, 36, 168, 236, 1.month * 24]
      expect(results.length).to eq(time_values.length)
      start_t = Time.now.beginning_of_month
      time_values.each_with_index do |x, y|
        end_t =  start_t + x
        next unless start_t.month == end_t.month
        conversion = ManageIQ::Consumption::TimeConverterHelper.number_of_intervals(end_t - start_t, interval)
        expect(conversion)
          .to eq(results[y]),
              "Expected with #{interval} for #{x} s to match #{results[y]}, start: #{start_t}, end: #{end_t}, got #{conversion}"
      end
    end

    it 'daily' do
      interval = 'daily'
      results = [1, 1, 1, 1, 1, 1, 1, 2, 7, 10, 1.month]
      expect(results.length).to eq(time_values.length)
      start_t = Time.now.beginning_of_month
      time_values.each_with_index do |x, y|
        end_t =  start_t + x
        next unless start_t.month == end_t.month
        conversion = ManageIQ::Consumption::TimeConverterHelper.number_of_intervals(end_t - start_t, interval)
        expect(conversion)
          .to eq(results[y]),
              "Expected with #{interval} for #{x} s to match #{results[y]}, start: #{start_t}, end: #{end_t}, got #{conversion}"
      end
    end

    it 'weekly' do
      interval = 'weekly'
      results = [1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 5]
      expect(results.length).to eq(time_values.length)
      start_t = Time.now.beginning_of_month
      time_values.each_with_index do |x, y|
        end_t =  start_t + x
        next unless start_t.month == end_t.month
        conversion = ManageIQ::Consumption::TimeConverterHelper.number_of_intervals(end_t - start_t, interval)
        expect(conversion)
            .to eq(results[y]),
                "Expected with #{interval} for #{x} s to match #{results[y]}, start: #{start_t}, end: #{end_t}, got #{conversion}"
      end
    end

    it 'monthly' do
      interval = 'monthly'
      results = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
      expect(results.length).to eq(time_values.length)
      start_t = Time.now.beginning_of_month
      time_values.each_with_index do |x, y|
        end_t =  start_t + x
        next unless start_t.month == end_t.month
        conversion = ManageIQ::Consumption::TimeConverterHelper.number_of_intervals(end_t - start_t, interval)
        expect(conversion)
            .to eq(results[y]),
                "Expected with #{interval} for #{x} s to match #{results[y]}, start: #{start_t}, end: #{end_t}, got #{conversion}"
      end
    end
  end
end