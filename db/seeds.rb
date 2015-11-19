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
  {title: "Voting Rights Matter", subtitle: "A historical overview of voting rights and restrictions in the US. This site is funded by the Democratic Party.", url: "http://www.votingrightsmatter.com/"}
  ])

StateWebsite.create([
  {state: "Ohio", initial: "OH", url: "http://voterlookup.sos.state.oh.us/voterlookup.aspx"},
  ])
 

