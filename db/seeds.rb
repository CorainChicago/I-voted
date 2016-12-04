Electioninfo.create([
  {title: "Election Protection", subtitle: "Working 365 days to advance and defend your right to vote.", url: "http://www.866ourvote.org/"},
  {title: "Open Secrets", subtitle: "...tracking money in U.S. politics and its effect on elections and public policy.", url: "http://www.opensecrets.org/"},
  {title: "League of Women Voters", subtitle: "Formed from the movement that secured the right to vote for women, the centerpiece of the League’s efforts remain to expand participation and give a voice to all Americans", url: "http://lwv.org/"},
  {title: "Voting Rights Matter", subtitle: "A historical overview of voting rights and restrictions in the US. This site is funded by the Democratic Party.", url: "http://www.votingrightsmatter.com/"},
  {title: "U.S. Election Assistance Commission", subtitle: "The U.S. Election Assistance Commission (EAC) was established by the Help America Vote Act of 2002 (HAVA).", url: "http://www.eac.gov/voter_resources/contact_your_state.aspx"},
  {title: "US Electoral College", subtitle: "The National Archives site with information about the electoral college and history. ", url: "http://www.archives.gov/federal-register/electoral-college/index.html"},
  {title: "Rock The Vote", subtitle: "Rock the Vote is the largest nonprofit and nonpartisan organization in the United States driving the youth vote to the polls.", url: "http://www.rockthevote.com/"},
  {title: "Elections & Voting", subtitle: "The White House website for voting", url: "https://www.whitehouse.gov/1600/elections-and-voting"},
  {title: "News Hour", subtitle: "Nonpartisan information on elections and politics from a public broadcaster.", url: "http://www.pbs.org/newshour/topic/politics/"},
  {title: "19th Amendment", subtitle: "The right of citizens of the United States to vote shall not be denied or abridged by the United States or by any State on account of sex.", url: "http://www.archives.gov/historical-docs/document.html?doc=13&title.raw=19th+Amendment+to+the+U.S.+Constitution:+Women%27s+Right+to+Vote"},
  {title: "Becoming a Poll Worker", subtitle: "Poll workers are essential to ensuring that elections are a success...", url: "http://www.eac.gov/voter_resources/become_a_poll_worker.aspx"},
  {title: "Learn about the Electoral College", subtitle: "An important part of the presidental election process", url: "https://www.khanacademy.org/humanities/history/american-civics-parent/american-civics/v/electoral-college"},
  {title: "US Vote Foundation", subtitle: "U.S. Vote Foundation (US Vote) and its initiative Overseas Vote, share a mission to facilitate and increase the participation of all U.S. voters in the electoral process", url: "https://www.usvotefoundation.org"},
  {title: "Vote Smart", subtitle: "Vote Smart's mission is to provide free, factual, unbiased information on candidates 
and elected officials to ALL Americans.", url: "http://votesmart.org/"},
  {title: "15th Amendment", subtitle: "Right of citizens of the United States to vote shall not be denied or abridged by the United States or by any state on account of race, color, or previous condition of servitude.", url:"https://www.loc.gov/rr/program/bib/ourdocs/15thamendment.html"
  }
  ])

records_state_websites = JSON.parse(File.read('public/us_secretary_of_states.json'))
records_state_websites.each do |record|
  StateWebsite.create!(name: record["state_name"], url: record["url"])
end

Rake::Task['db:update_state_election_info'].invoke 

Rake::Task['db:update_state_voter_info'].invoke 
