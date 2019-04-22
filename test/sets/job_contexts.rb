module Contexts
  module JobContexts
    def create_jobs
      @cashier = FactoryBot.create(:job)
      @mopping = FactoryBot.create(:job, name: "Mopping")
      @making  = FactoryBot.create(:job, name: "Ice cream making")
      @mover   = FactoryBot.create(:job, name: "Mover", active: false)
    end

    def remove_jobs
      @cashier.destroy
      @mopping.destroy
      @making.destroy
      @mover.destroy
    end
  end
end