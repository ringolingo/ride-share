########################################################
# Step 1: Establish the layers
#
# The outermost layer is "ride_share".
# It has nested in it each individual driver in the ride share.
# The individual drivers are next to each other in this layer.
#
# Nested within the "ride_share" layer is the "drivers" layer.
# Each driver is next to every other driver.
#
# Nested within the "drivers" layer is the "ride_info" layer.
# All rides by one driver are next to the other rides by the same driver.

########################################################
# Step 2: Assign a data structure to each layer
#
# ride_share: hash
# drivers: key-value pairs where the value is an array
# ride_info: hashes

########################################################
# Step 3: Make the data structure!

ride_share = {
    DR0001: [
        {
            date: "3rd Feb 2016",
            cost: 10,
            rider: "RD0003",
            rating: 3
        },
        {
            date: "3rd Feb 2016",
            cost: 30,
            rider: "RD0015",
            rating: 4
        },
        {
            date: "5th Feb 2016",
            cost: 45,
            rider: "RD0003",
            rating: 2
        }
    ],
    DR0002: [
        {
            date: "3rd Feb 2016",
            cost: 25,
            rider: "RD0073",
            rating: 5
        },
        {
            date: "4th Feb 2016",
            cost: 15,
            rider: "RD0013",
            rating: 1
        },
        {
            date: "5th Feb 2016",
            cost: 35,
            rider: "RD0066",
            rating: 3
        }

    ],
    DR0003: [
        {
            date: "4th Feb 2016",
            cost: 5,
            rider: "RD0066",
            rating: 5
        },
        {
            date: "5th Feb 2016",
            cost: 50,
            rider: "RD0003",
            rating: 2
        }
    ],
    DR0004: [
        {
            date: "3rd Feb 2016",
            cost: 5,
            rider: "RD0022",
            rating: 5
        },
        {
            date: "4th Feb 2016",
            cost: 10,
            rider: "RD0022",
            rating: 4
        },
        {
            date: "5th Feb 2016",
            cost: 20,
            rider: "RD0073",
            rating: 5
        }
    ]
}

########################################################
# Step 4: Total Driver's Earnings and Number of Rides

# 1. number of rides each driver has given
ride_share.each do |driver, ride_array|
  total_rides = ride_array.length
  puts "Driver #{driver} has given #{total_rides} rides."
end



# 2. total amount of money each driver has made
def total_earnings(array)
  driver_earnings = array.sum { |ride| ride[:cost] }
  return driver_earnings
end

earnings_array = ride_share.map do |driver, ride_array|
  { id: driver, earnings: total_earnings(ride_array) }
end

earnings_array.each do |driver|
  puts "Driver #{driver[:id]} made $#{driver[:earnings]}"
end



# 3. average rating for each driver
def average_rating(ride_array)
  ratings_total = ride_array.sum { |ride| ride[:rating] }
  ride_quantity = ride_array.length.to_f
  average_rating = (ratings_total/ride_quantity).truncate(1)
  return average_rating
end

rating_array = ride_share.map do |driver, ride_array|
  { id: driver, rating: average_rating(ride_array) }
end

rating_array.each do |driver|
  puts "Driver #{driver[:id]} has an average rating of #{driver[:rating]}"
end



# 4. which driver has made the most money
most_paid_driver = earnings_array.max_by { |driver| driver[:earnings] }
puts "#{most_paid_driver[:id]} has made the most money: $#{most_paid_driver[:earnings]}"



# 5. which driver has the highest average rating
highest_rated_driver = rating_array.max_by { |driver| driver[:rating] }
puts "#{highest_rated_driver[:id]} has the highest rating: #{highest_rated_driver[:rating]}"



# 6. for each driver, on which day did they make the most money
ride_share.each do |driver, ride_array|
  driver_hash = {}
  ride_array.each do |ride|
    if driver_hash.include?(ride[:date])
      driver_hash[ride[:date]] += ride[:cost]
    else
      driver_hash[ride[:date]] = ride[:cost]
    end
  end
  lucrative_date = driver_hash.max_by { |date, value| value }
  puts "#{driver} made the most money on #{lucrative_date[0]}: $#{lucrative_date[1]}"
end
