# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
css = Book.create(title: 'CSSucks', pages: 420, year: 2019, cover_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')
hunger = Book.create(title: 'The Hunger Games', pages: 374, year: 2008, cover_url: 'https://images.gr-assets.com/books/1447303603l/2767052.jpg')
potter = Book.create(title: 'Harry Potter and the Order of the Phoenix', pages: 870, year: 2003, cover_url: 'https://images.gr-assets.com/books/1546910265l/2.jpg')
mockingbird = Book.create(title: 'To Kill a Mockingbird', pages: 324, year: 1960, cover_url: 'https://images.gr-assets.com/books/1552035043l/2657.jpg')
pride = Book.create(title: 'Pride And Prejudice', pages: 279, year: 1813, cover_url: 'https://images.gr-assets.com/books/1320399351l/1885.jpg')
narnia = Book.create(title: 'The Chronicles of Narnia', pages: 767, year: 1956, cover_url: 'https://images.gr-assets.com/books/1449868701l/11127.jpg')
farm = Book.create(title: 'Animal Farm', pages: 122, year: 1945, cover_url: 'https://images.gr-assets.com/books/1424037542l/7613.jpg')
hobbit = Book.create(title: 'The Hobbit', pages: 310, year: 1937, cover_url: 'https://g.christianbook.com/g/slideshow/9/928227/main/928227_1_ftc.jpg')
fellowship = Book.create(title: 'The Fellowship Of The Rings', pages: 423, year: 1954, cover_url: 'http://images.mentalfloss.com/sites/default/files/styles/width-constrained-728/public/507311-_amazon91jbdarvqml.jpg')
towers = Book.create(title: 'The Two Towers', pages: 352, year: 1954, cover_url: 'http://img1.imagesbn.com/p/9780547952024_p0_v1_s260x420.JPG')
king = Book.create(title: 'The Return Of The King', pages: 416, year: 1955, cover_url: 'https://images-na.ssl-images-amazon.com/images/I/41Qx%2BidkxsL.jpg')

user_1 = User.create(username: "Spacehater123")
user_2 = User.create(username: "CozyLittleBookJournal")
user_3 = User.create(username: "Anonymous")
user_4 = User.create(username: "Spacehater456")
user_5 = User.create(username: "Thatoneexgirlfriend")
user_6 = User.create(username: "Space Good")
user_7 = User.create(username: "Ronald Ward")
user_8 = User.create(username: "Dell MacApple")
user_9 = User.create(username: "Demetrius Levenworth")
user_10 = User.create(username: "Ed Bed")
user_11 = User.create(username: "Tex Montreal")
user_12 = User.create(username: "Monica Labrador")
user_13 = User.create(username: "AmericaSolid")
user_14 = User.create(username: "Molly Popper")
user_15 = User.create(username: "Stegosaurus Jones")
user_16 = User.create(username: "Molly Pepper")
user_17 = User.create(username: "Emma Stout")

astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
css.authors << Author.find_or_create_by(name: 'Matt Weiss')
hunger.authors << Author.find_or_create_by(name: 'Suzanne Collins')
potter.authors << Author.find_or_create_by(name: 'J.K. Rowling')
mockingbird.authors << Author.find_or_create_by(name: 'Harper Lee')
pride.authors << Author.find_or_create_by(name: 'Jane Austen')
pride.authors << Author.find_or_create_by(name: 'Anna Quindlen')
narnia.authors << Author.find_or_create_by(name: 'C.S. Lewis')
narnia.authors << Author.find_or_create_by(name: 'Pauline Baynes')
farm.authors << Author.find_or_create_by(name: 'George Orwell')
hobbit.authors << Author.find_or_create_by(name: 'J.R.R. Tolkien')
fellowship.authors << Author.find_or_create_by(name: 'J.R.R. Tolkien')
towers.authors << Author.find_or_create_by(name: 'J.R.R. Tolkien')
king.authors << Author.find_or_create_by(name: 'J.R.R. Tolkien')

user_2.reviews.create(astronaut)
# astronaut.reviews.create(body: "I have so many good things to say about this book I don't think they'll all fit into one review (for my full review, including my four-year-old's reaction to it, please visit my blog, Cozy Little Book Journal).", headline: 'I have so many good things to say about this book', rating: 5).find_or_create_by(username: 'CozyLittleBookJournal')

user_3.reviews.create(astronaut)
# astronaut.reviews.create(body: "Have you ever wanted to know the life of an astronaut? How do you even get to be one? What do they do, especially when on earth? Why do they even do it? And how do you combine that with having a family? This wonderful new book will tell you all about it.", headline: 'Have you ever wanted to know the life of an astronaut?', rating: 5).find_or_create_by(username: 'Anonymous')

user_1.reviews.create(astronaut)
# astronaut.reviews.create(body: 'I hate space for some reason', headline: 'Boo Space', rating: 2).find_or_create_by(username: 'Spacehater123')

user_4.reviews.create(astronaut)
# astronaut.reviews.create(body: 'I also hate space for some reason', headline: 'Boo Space2', rating: 1).find_or_create_by(username: 'Spacehater456')

user_5.reviews.create(astronaut)
# astronaut.reviews.create(body: 'That was way more exciting', headline: "Wasn't The Martian based on a true story?", rating: 3).find_or_create_by(username: 'Thatoneexgirlfriend')

user_6.reviews.create(astronaut)
# astronaut.reviews.create(body: 'I guess they can if you take videos and post them on youtube', headline: 'In space, no one can hear you play guitar', rating: 4).find_or_create_by(username: 'Space Good')

user_2.reviews.create(css)
# css.reviews.create(body: "Make Your Psychiatrist Go To The Gym More", headline: "Scary Truths That Will", rating: "1").find_or_create_by(username: "CozyLittleBookJournal")

user_7.reviews.create(css)
# css.reviews.create(body: "Agriculture Secretary Thomas J. Vilsack", headline: "Photoshop Tips From", rating: "2").find_or_create_by(username: "Ronald Ward")

user_8.reviews.create(css)
# css.reviews.create(body: "Keep To Themselves", headline: "Secrets Accountants", rating: "3").find_or_create_by(username: "Dell MacApple")

user_9.reviews.create(css)
# css.reviews.create(body: "6 Practical Beard Care Tips", headline: "Scarlett Johansson's", rating: "4").find_or_create_by(username: "Demetrius Levenworth")

user_10.reviews.create(css)
# css.reviews.create(body: "Ernest Moniz Save Skin Care?", headline: "Will Energy Secretary", rating: "5").find_or_create_by(username: "Ed Bed")

user_15.reviews.create(css)
# css.reviews.create(body: "Thinks About In The Bathroom", headline: "Facts Your Elected Official", rating: "3").find_or_create_by(username: "Stegosaurus Jones")

user_2.reviews.create(hunger)
# hunger.reviews.create(body: "Secrets From Batman", headline: "Hilarious Dental Care", rating: "1").find_or_create_by(username: "CozyLittleBookJournal")

user_13.reviews.create(hunger)
# hunger.reviews.create(body: "Make Psychologists Feel Ashamed", headline: "Shocking Things That", rating: "3").find_or_create_by(username: "AmericaSolid")

user_8.reviews.create(hunger)
# hunger.reviews.create(body: "Your Web Designer Feel More Attractive", headline: "Incredible Facts That Will Make", rating: "3").find_or_create_by(username: "Dell MacApple")

user_10.reviews.create(hunger)
# hunger.reviews.create(body: "Receptionists Won't Tell Their Friends", headline: "Staggering Things", rating: "4").find_or_create_by(username: "Ed Bed")

user_11.reviews.create(hunger)
# hunger.reviews.create(body: "Save Trumpet Playing?", headline: "Can Martin Scorsese", rating: "5").find_or_create_by(username: "Tex Montreal")

user_12.reviews.create(hunger)
# hunger.reviews.create(body: "Surprising Metallurgy Secrets", headline: "Ashton Kutcher's 15", rating: "3").find_or_create_by(username: "Monica Labrador")

user_7.reviews.create(potter)
# potter.reviews.create(body: "Your Senator Will Never Learn", headline: "Troubling Truths", rating: "1").find_or_create_by(username: "Ronald Ward")

user_13.reviews.create(potter)
# potter.reviews.create(body: "About Lady Gaga", headline: "Scandalous Truths", rating: "4").find_or_create_by(username: "AmericaSolid")

user_9.reviews.create(potter)
# potter.reviews.create(body: "Awesome Archery Tips", headline: "Kanye West's Top 6", rating: "3").find_or_create_by(username: "Demetrius Levenworth")

user_10.reviews.create(potter)
# potter.reviews.create(body: "That Make Plumbers Nervous", headline: "Horrible Secrets", rating: "3").find_or_create_by(username: "Ed Bed")

user_11.reviews.create(potter)
# potter.reviews.create(body: "Tips From Jay-Z", headline: "Sexy Speed Skating", rating: "4").find_or_create_by(username: "Tex Montreal")

user_14.reviews.create(potter)
# potter.reviews.create(body: "About Soldering", headline: "The Embarassing Truth", rating: "5").find_or_create_by(username: "Molly Popper")

user_7.reviews.create(mockingbird)
# mockingbird.reviews.create(body: "CEOs Write In Their Journals", headline: "Hilarious Truths", rating: "1").find_or_create_by(username: "Ronald Ward")

user_8.reviews.create(mockingbird)
# mockingbird.reviews.create(body: "David Wichmann's 10 Amazing Halo Tips", headline: "UnitedHealth CEO", rating: "5").find_or_create_by(username: "Dell MacApple")

user_10.reviews.create(mockingbird)
# mockingbird.reviews.create(body: "Tips From AT&T CEO Randall L. Stephenson", headline: "Big Wave Surfing", rating: "3").find_or_create_by(username: "Ed Bed")

user_15.reviews.create(mockingbird)
# mockingbird.reviews.create(body: "Your Doctor Is Using Against You", headline: "Unbelievable Facts", rating: "3").find_or_create_by(username: "Stegosaurus Jones")

user_12.reviews.create(mockingbird)
# mockingbird.reviews.create(body: "Make Therapists Afraid", headline: "Secrets That", rating: "4").find_or_create_by(username: "Monica Labrador")

user_14.reviews.create(mockingbird)
# mockingbird.reviews.create(body: "Make Your Contractor Feel Sexually Confused", headline: "5 Things That Will", rating: "5").find_or_create_by(username: "Molly Popper")

user_13.reviews.create(pride)
# pride.reviews.create(body: "Save Papercraft?", headline: "Will William Shatner", rating: "1").find_or_create_by(username: "AmericaSolid")

user_8.reviews.create(pride)
# pride.reviews.create(body: "Physicians Won't Admit", headline: "Amazing Truths", rating: "2").find_or_create_by(username: "Dell MacApple")

user_11.reviews.create(pride)
# pride.reviews.create(body: "Boyfriends Eat More Vegetables", headline: "Secrets That Make", rating: "3").find_or_create_by(username: "Tex Montreal")

user_12.reviews.create(pride)
# pride.reviews.create(body: "12 Shocking Tree Pruning Tips", headline: "Arnold Schwarzenegger's", rating: "3").find_or_create_by(username: "Monica Labrador")

user_16.reviews.create(pride)
# pride.reviews.create(body: "From Bill Gates", headline: "Leaf Blowing Secrets", rating: "4").find_or_create_by(username: "Molly Popper")

user_17.reviews.create(pride)
# pride.reviews.create(body: "Family Doctors Don't Like To Think About", headline: "Mind-Blowing Secrets", rating: "4").find_or_create_by(username: "Emma Stout")

user_7.reviews.create(narnia)
# narnia.reviews.create(body: "That Will Make Your Neighbor Angry", headline: "Jaw-Dropping Things", rating: "1").find_or_create_by(username: "Ronald Ward")

user_13.reviews.create(narnia)
# narnia.reviews.create(body: "That Make Attorneys Feel Aroused", headline: "Surprising Facts", rating: "2").find_or_create_by(username: "AmericaSolid")

user_9.reviews.create(narnia)
# narnia.reviews.create(body: "About The ghost of Steve Jobs", headline: "The Alarming Truth", rating: "3").find_or_create_by(username: "Demetrius Levenworth")

user_10.reviews.create(narnia)
# narnia.reviews.create(body: "Top 20 Javascript Tips", headline: "Will Smith's", rating: "4").find_or_create_by(username: "Ed Bed")

user_12.reviews.create(narnia)
# narnia.reviews.create(body: "Publicist Is Hiding From You", headline: "Truths Your", rating: "4").find_or_create_by(username: "Monica Labrador")

user_17.reviews.create(narnia)
# narnia.reviews.create(body: "Your Proctologist Gets Choked Up About", headline: "Terrifying Things", rating: "5").find_or_create_by(username: "Emma Stout")

user_2.reviews.create(farm)
# farm.reviews.create(body: "That Will Make Your Urologist Sleepy", headline: "Frightening Secrets", rating: "5").find_or_create_by(username: "CozyLittleBookJournal")

user_7.reviews.create(farm)
# farm.reviews.create(body: "Fathers Nervous", headline: "Truths That Make", rating: "5").find_or_create_by(username: "Ronald Ward")

user_15.reviews.create(farm)
# farm.reviews.create(body: "Secrets From Johnny Depp", headline: "Unbelievable Frisbee Golf", rating: "3").find_or_create_by(username: "Stegosaurus Jones")

user_11.reviews.create(farm)
# farm.reviews.create(body: "About Pet Care", headline: "Awesome Facts", rating: "3").find_or_create_by(username: "Tex Montreal")

user_14.reviews.create(farm)
# farm.reviews.create(body: "Are Hiding From You", headline: "Secrets Spouses", rating: "4").find_or_create_by(username: "Molly Popper")

user_17.reviews.create(farm)
# farm.reviews.create(body: "Incredible Microsoft Excel Tips", headline: "Julia Roberts's 15", rating: "5").find_or_create_by(username: "Emma Stout")

user_13.reviews.create(hobbit)
# hobbit.reviews.create(body: "Save Gymnastics?", headline: "Can Steve Carell", rating: "1").find_or_create_by(username: "AmericaSolid")

user_9.reviews.create(hobbit)
# hobbit.reviews.create(body: "Will Make Your Electrician Mad", headline: "Truths That", rating: "2").find_or_create_by(username: "Demetrius Levenworth")

user_10.reviews.create(hobbit)
# hobbit.reviews.create(body: "From Former President Jimmy Carter", headline: "Rock Climbing Tips", rating: "3").find_or_create_by(username: "Ed Bed")

user_15.reviews.create(hobbit)
# hobbit.reviews.create(body: "Your Bus Driver Doesn't Know About", headline: "Dangerous Things", rating: "5").find_or_create_by(username: "Stegosaurus Jones")

user_12.reviews.create(hobbit)
# hobbit.reviews.create(body: "Will Make Your Professor Uncomfortable", headline: "Fascinating Facts That", rating: "4").find_or_create_by(username: "Monica Labrador")

user_17.reviews.create(hobbit)
# hobbit.reviews.create(body: "Make Plastic Surgeons Feel Sexy", headline: "Terrifying Truths That", rating: "5").find_or_create_by(username: "Emma Stout")

user_13.reviews.create(fellowship)
# fellowship.reviews.create(body: "Mother Isn't Telling You", headline: "Scary Secrets Your", rating: "1").find_or_create_by(username: "AmericaSolid")

user_8.reviews.create(fellowship)
# fellowship.reviews.create(body: "Supervisors Won't Tell You", headline: "Embarrassing Things", rating: "2").find_or_create_by(username: "Dell MacApple")

user_9.reviews.create(fellowship)
# fellowship.reviews.create(body: "PowerPoint Tips From Brad Pitt", headline: "Little-Known", rating: "1").find_or_create_by(username: "Demetrius Levenworth")

user_15.reviews.create(fellowship)
# fellowship.reviews.create(body: "Baristas Are Using Against You", headline: "Fascinating Things", rating: "3").find_or_create_by(username: "Stegosaurus Jones")

user_11.reviews.create(fellowship)
# fellowship.reviews.create(body: "Grandmothers Work Harder", headline: "Facts That Make", rating: "1").find_or_create_by(username: "Tex Montreal")

user_12.reviews.create(fellowship)
# fellowship.reviews.create(body: "Of Joke Writing", headline: "The Surprising Secrets", rating: "5").find_or_create_by(username: "Monica Labrador")

user_2.reviews.create(towers)
# towers.reviews.create(body: "That Will Make Your Surgeon Stronger", headline: "Terrible Secrets", rating: "1").find_or_create_by(username: "CozyLittleBookJournal")

user_7.reviews.create(towers)
# towers.reviews.create(body: "Airline Pilot Tweets About", headline: "Truths Your", rating: "2").find_or_create_by(username: "Ronald Ward")

user_8.reviews.create(towers)
# towers.reviews.create(body: "Collecting Tips From Robert De Niro", headline: " Jaw-Dropping Stamp", rating: "3").find_or_create_by(username: "Dell MacApple")

user_10.reviews.create(towers)
# towers.reviews.create(body: "Employees Don't Know About", headline: "Incredible Things", rating: "3").find_or_create_by(username: "Ed Bed")

user_11.reviews.create(towers)
# towers.reviews.create(body: "Will Make Your Local Politician Work Harder", headline: "Awesome Secrets That", rating: "1").find_or_create_by(username: "Tex Montreal")

user_12.reviews.create(towers)
# towers.reviews.create(body: "Save Street Racing?", headline: "Will Leonardo DiCaprio", rating: "5").find_or_create_by(username: "Monica Labrador")

user_7.reviews.create(king)
# king.reviews.create(body: " Waiters Sleepy", headline: "Facts That Make", rating: "1").find_or_create_by(username: "Ronald Ward")

user_13.reviews.create(king)
# king.reviews.create(body: "Will Never Admit", headline: "Truths Your Grandfather", rating: "2").find_or_create_by(username: "AmericaSolid")

user_8.reviews.create(king)
# king.reviews.create(body: "From Chris Pine", headline: "Surprising Tree Climbing Tips", rating: "3").find_or_create_by(username: "Dell MacApple")

user_9.reviews.create(king)
# king.reviews.create(body: "That Make Lawyers Angry", headline: "Amazing Truths", rating: "3").find_or_create_by(username: "Demetrius Levenworth")

user_10.reviews.create(king)
# king.reviews.create(body: "Will Make Your Local Politician Nervous", headline: "Mind-Blowing Secrets That", rating: "2").find_or_create_by(username: "Ed Bed")

user_15.reviews.create(king)
# king.reviews.create(body: "5 Mind-Blowing Angry Birds Tips", headline: "Netflix CEO Reed Hastings's", rating: "5").find_or_create_by(username: "Stegosaurus Jones")
