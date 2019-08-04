# frozen_string_literal: true

module InfectionReportStateMachine
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm whiny_transitions: false do
      state :zero_reports, initial: true
      state :one_reports, :two_reports, :three_reports

      event :report_as_infected, guards: [:completed?] do
        transitions from: :zero_reports, to: :one_reports
        transitions from: :one_reports, to: :two_reports
        transitions from: :two_reports, to: :three_reports, after: :declare_survivor_as_infected
      end
    end

    def completed?
      !three_reports?
    end

    def declare_survivor_as_infected
      self.infected = true
      save
    end
  end
end
