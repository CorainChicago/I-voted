# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Electioninfo.create([
  {title: "Open Secrets", subtitle: "...tracking money in U.S. politics and its effect on elections and public policy.", url: "http://www.opensecrets.org/"},
  {title: "League of Women Voters", subtitle: "'Formed from the movement that secured the right to vote for women, the centerpiece of the League’s efforts remain to expand participation and give a voice to all Americans'", url: "http://lwv.org/"},
  {title: "Voting Rights Matter", subtitle: "A historical overview of voting rights and restrictions in the US. This site is funded by the Democratic Party.", url: "http://www.votingrightsmatter.com/"}, 
  {title: "U.S. Election Assistance Commission", subtitle: "The U.S. Election Assistance Commission (EAC) was established by the Help America Vote Act of 2002 (HAVA).", url: "http://www.eac.gov/voter_resources/contact_your_state.aspx"}, 
  {title: "US lectoral College", subtitle: "The National Archives site with information about the electoral college and history. ", url: "http://www.archives.gov/federal-register/electoral-college/index.html"},
  {title: "Rock The Vote", subtitle: "Rock the Vote is the largest nonprofit and nonpartisan organization in the United States driving the youth vote to the polls.", url: "http://www.rockthevote.com/"}
  ])

records = JSON.parse(File.read('public/state_data.json'))
records.each do |record|
  if record["Early In-Person Voting"] == "✓" || record["Early In-Person Voting"] == "✓ " 
    record["Early In-Person Voting"] = true
  else
    record["Early In-Person Voting"] = false
  end

  if record["No Excuse Absentee Voting"] == "✓" || record["No Excuse Absentee Voting"] == "✓ "
    record["No Excuse Absentee Voting"] = true
  else
    record["No Excuse Absentee Voting"] = false
  end

  if record["Absentee Voting with Excuse"] == "✓" || record["Absentee Voting with Excuse"] == "✓ "
    record["Absentee Voting with Excuse"] = true
  else
    record["Absentee Voting with Excuse"] = false
  end

  if record["Same Day Voter Registration"] == "✓" || record["Same Day Voter Registration"] == "✓ "
    record["Same Day Voter Registration"] = true
  else
    record["Same Day Voter Registration"] = false
  end

  if record["All-Mail Voting"] == "✓" || record["All-Mail Voting"] == "✓ "
    record["All-Mail Voting"] = true
  else
    record["All-Mail Voting"] = false
  end

  StateVotingInformation.create!(
      name: record["name"], 
      early_in_person_voting: record["Early In-Person Voting"],no_excuse_absentee_voting: record["No Excuse Absentee Voting"],  absentee_voting_with_excuse: ["Absentee Voting with Excuse"],same_day_voter_registration: record["Same Day Voter Registration"], all_mail_voting: record["All Mail Voting"], voter_id_on_election_day: record["Voter ID on Election Day"])
end


require 'csv'

zip_files = ['db/zipcodes/us_postal_codes.csv', 'db/zipcodes/us_postal_codes_two.csv', 'db/zipcodes/us_postal_codes_three.csv', 'db/zipcodes/us_postal_codes_four.csv', 'db/zipcodes/us_postal_codes_five.csv', 'db/zipcodes/us_postal_codes_six.csv']

zip_files.each do |file|

  CSV.foreach(file) do |row|
  Zipcode.create!(zip: row[0].to_i, state_name: row[2], abbreviation: row[3])
  end
end


