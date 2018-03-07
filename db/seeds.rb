c1 = Category.create(name: "Other", description: "Anything you want it to be.")
c2 = Category.create(name: "Environmentalism", description: "Saving the world, one seal at a time.")

u1 = User.create(uid: "foo")
u2 = User.create(uid: "bar")

Job.create(
  title: "AI Risk Policy Manager",
  description: "FHI seeks a human with sophisticated knowledge of AI systems " +
    "to assist with drafting of strategy documents and contingency planning for when " +
    "it all goes wrong.\n\n###Key skills\n\n* working in teams\n* good spelling\n* concealed-carry licence" +
    "\n\n**No time-wasters please.**",
  category: c1,
  time_commitment: 0,
  url: "http://apple.com",
  owner_name: "John Appleseed",
  owner_id: "foo",
  user: u1
)

Job.create(
  title: "Brian Tomasik genuflector",
  description: "FHI seeks a human with sophisticated knowledge of AI systems " +
    "to assist with drafting of strategy documents and contingency planning for when " +
    "it all goes wrong.\n\n###Key skills\n\n* working in teams\n* good spelling\n* concealed-carry licence" +
    "\n\n**No time-wasters please.**",
  category: c2,
  time_commitment: 0,
  url: "http://apple.com",
  owner_name: "John Appleseed",
  owner_id: "foo",
  user: u1
)

Job.create(
  title: "Will MacAskill impersonator",
  description: "FHI seeks a human with sophisticated knowledge of AI systems " +
    "to assist with drafting of strategy documents and contingency planning for when " +
    "it all goes wrong.\n\n###Key skills\n\n* working in teams\n* good spelling\n* concealed-carry licence" +
    "\n\n**No time-wasters please.**",
  category: c1,
  time_commitment: 0,
  url: "http://apple.com",
  owner_name: "Steven Toast",
  owner_id: "foo",
  user: u2
)

Project.create(
  title: "EA projects board",
  description: "I think we're missing one place that lists all the EA openings " +
    "and EA side-projects the community knows about. I'd be willing to help get it off" +
    "the ground, and put $1000 of my own money into making it happen.\n\n" +
    "Who's interested?",
  budget: 1000,
  contact_email: "henry@henrystanley.com",
  owner_name: "Steven Toast",
  owner_id: "bar",
  category: Category.last,
  user: u2
)
