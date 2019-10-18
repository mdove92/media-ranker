require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(title: "MAMOMEMO", category: "book", publication_year: 2008, creator: "MacMac Do", description: "A riveting autobiography")
  }
  it "can be instantiated" do
    # Assert
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_work.save
    work = Work.first
    [:title, :category, :publication_year, :creator, :description].each do |field|

      # Assert
      expect(work).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many votes" do
      # Arrange
      new_work.save

      new_user = User.create(username: "Junedog")
      vote1 = Vote.create(user_id: params[:user_id], work_id: params[:work_id])
      vote2 = Vote.create(user_id: params[:user_id], work_id: params[:work_id])
      # Assert
      expect(new_work.votes.count).must_equal 2
      new_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must have a name" do
      # Arrange
      new_work.title = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      # expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # describe "count_rides" do
    #   it "returns nil if the passenger has no rides" do
    #     new_passenger.save
    #     expect(new_passenger.count_rides).must_equal 0
    #   end
    #   it "returns the correct total for the number of rides a passenger has taken" do
    #     new_passenger.save
    #     new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
    #     trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234.00)
    #     trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334.00)

    #     expect(new_passenger.count_rides).must_equal 2
    #     expect(new_passenger.count_rides).must_be_instance_of Integer
    #   end
    # end

    # describe "total_charges" do
    #   it "returns 0 if the rider has no rides" do
    #     new_passenger.save
    #     expect(new_passenger.total_charges).must_equal 0
    #   end

    #   it "must return the total spending of the passenger's trips as a float" do
    #     new_passenger.save

    #     new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
    #     trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234.00)
    #     trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334.00)

    #     expect(new_passenger.total_charges).must_equal 7568.00
    #     expect(new_passenger.total_charges).must_be_instance_of Float
    #   end
    # end

    # You may have additional methods to test
  end
end
