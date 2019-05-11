require "rails_helper"

describe "user sees all books" do
  describe "they visit /books" do

    it "gives error if no books" do
      visit books_path

      expect(page).to have_content("No books!")
    end

    it "displays all books if there are books" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      css = Book.create(title: 'CSSucks', pages: 420, year: 2019, cover_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')

      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      css.authors << Author.find_or_create_by(name: 'Matt Weiss')

      visit books_path

      expect(page).to have_link(astronaut.title)
      expect(page).to have_link(css.title)
      expect(page).to have_content(astronaut.pages)
      expect(page).to have_content(css.pages)
      expect(page).to have_content(astronaut.year)
      expect(page).to have_content(css.year)
      expect(page).to have_link(astronaut.authors[0].name)
      expect(page).to have_link(css.authors[0].name)
      expect(page).to have_xpath("//img[contains(@src,'#{astronaut.cover_url}')]")
      expect(page).to have_xpath("//img[contains(@src,'#{css.cover_url}')]")
    end

    it "displays a button that directs to a new book creation page" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      css = Book.create(title: 'CSSucks', pages: 420, year: 2019, cover_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')

      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      css.authors << Author.find_or_create_by(name: 'Matt Weiss')

      visit books_path

      expect(page).to have_link("New Book")

      click_link("New Book")

      expect(current_path).to eq('/books/new')
    end

    describe "displays stats about all books" do
      it "displays three highest-rated books (book title)" do
        astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
        css = Book.create(title: 'CSSucks', pages: 420, year: 2019, cover_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')
        hunger = Book.create(title: 'The Hunger Games', pages: 374, year: 2008, cover_url: 'https://images.gr-assets.com/books/1447303603l/2767052.jpg')
        potter = Book.create(title: 'Harry Potter and the Order of the Phoenix', pages: 870, year: 2003, cover_url: 'https://images.gr-assets.com/books/1546910265l/2.jpg')
        mockingbird = Book.create(title: 'To Kill a Mockingbird', pages: 324, year: 1960, cover_url: 'https://images.gr-assets.com/books/1552035043l/2657.jpg')
        pride = Book.create(title: 'Pride And Prejudice', pages: 279, year: 1813, cover_url: 'https://images.gr-assets.com/books/1320399351l/1885.jpg')
        narnia = Book.create(title: 'The Chronicles of Narnia', pages: 767, year: 1956, cover_url: 'https://images.gr-assets.com/books/1449868701l/11127.jpg')

        user_1 = User.create(username: "Snozzlebert Chesterfield")
        user_2 = User.create(username: "Snorkeldink Crumplehorn")
        user_3 = User.create(username: "Fiddlestick Calldispatch")
        user_4 = User.create(username: "Bumblebee Cankersore")
        user_5 = User.create(username: "Brendadirk Curdlesnoot")
        user_6 = User.create(username: "Bedlington Cankersnuff")
        user_7 = User.create(username: "Beetlejuice Cragglethatch")
        user_8 = User.create(username: "Buckingham Creamsicle")
        user_9 = User.create(username: "Burlington Anglerfish")
        user_10 = User.create(username: "Bandicoot Crackerdog")
        user_11 = User.create(username: "Botany Chuckecheese")
        user_12 = User.create(username: "Benadryl Custardbath")
        user_13 = User.create(username: "Rinkydink Rainbowfish")
        user_14 = User.create(username: "Birdbox Bandersnatch")
        user_15 = User.create(username: "Whippersnitch Cottagecheese")
        user_16 = User.create(username: "Beezlebub Banglesnatch")
        user_17 = User.create(username: "Cadbury Bonaparte")

        astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
        css.authors << Author.find_or_create_by(name: 'Matt Weiss')
        hunger.authors << Author.find_or_create_by(name: 'Suzanne Collins')
        potter.authors << Author.find_or_create_by(name: 'J.K. Rowling')
        mockingbird.authors << Author.find_or_create_by(name: 'Harper Lee')
        pride.authors << Author.find_or_create_by(name: 'Jane Austen')
        pride.authors << Author.find_or_create_by(name: 'Anna Quindlen')
        narnia.authors << Author.find_or_create_by(name: 'C.S. Lewis')
        narnia.authors << Author.find_or_create_by(name: 'Pauline Baynes')

        user_2.reviews.create(book: astronaut, body: "I have so many good things to say about this book I don't think they'll all fit into one review (for my full review, including my four-year-old's reaction to it, please visit my blog, Cozy Little Book Journal).", headline: 'I have so many good things to say about this book', rating: 5)
        user_3.reviews.create(book: astronaut, body: "Have you ever wanted to know the life of an astronaut? How do you even get to be one? What do they do, especially when on earth? Why do they even do it? And how do you combine that with having a family? This wonderful new book will tell you all about it.", headline: 'Have you ever wanted to know the life of an astronaut?', rating: 5)
        user_1.reviews.create(book: astronaut, body: 'I hate space for some reason', headline: 'Boo Space', rating: 5)
        user_4.reviews.create(book: astronaut, body: 'I also hate space for some reason', headline: 'Boo Space2', rating: 5)
        user_5.reviews.create(book: astronaut, body: 'That was way more exciting', headline: "Wasn't The Martian based on a true story?", rating: 5)
        user_6.reviews.create(book: astronaut, body: 'I guess they can if you take videos and post them on youtube', headline: 'In space, no one can hear you play guitar', rating: 5)
        user_2.reviews.create(book: css, body: "Make Your Psychiatrist Go To The Gym More", headline: "Scary Truths That Will", rating: 1)
        user_7.reviews.create(book: css, body: "Agriculture Secretary Thomas J. Vilsack", headline: "Photoshop Tips From", rating: 1)
        user_8.reviews.create(book: css, body: "Keep To Themselves", headline: "Secrets Accountants", rating: 1)
        user_9.reviews.create(book: css, body: "6 Practical Beard Care Tips", headline: "Scarlett Johansson's", rating: 1)
        user_10.reviews.create(book: css, body: "Ernest Moniz Save Skin Care?", headline: "Will Energy Secretary", rating: 1)
        user_15.reviews.create(book: css, body: "Thinks About In The Bathroom", headline: "Facts Your Elected Official", rating: 1)
        user_2.reviews.create(book: hunger, body: "Secrets From Batman", headline: "Hilarious Dental Care", rating: 4)
        user_13.reviews.create(book: hunger, body: "Make Psychologists Feel Ashamed", headline: "Shocking Things That", rating: 4)
        user_8.reviews.create(book: hunger, body: "Your Web Designer Feel More Attractive", headline: "Incredible Facts That Will Make", rating: 4)
        user_10.reviews.create(book: hunger, body: "Receptionists Won't Tell Their Friends", headline: "Staggering Things", rating: 4)
        user_11.reviews.create(book: hunger, body: "Save Trumpet Playing?", headline: "Can Martin Scorsese", rating: 4)
        user_12.reviews.create(book: hunger, body: "Surprising Metallurgy Secrets", headline: "Ashton Kutcher's 15", rating: 4)
        user_7.reviews.create(book: potter, body: "Your Senator Will Never Learn", headline: "Troubling Truths", rating: 3)
        user_13.reviews.create(book: potter, body: "About Lady Gaga", headline: "Scandalous Truths", rating: 3)
        user_9.reviews.create(book: potter, body: "Awesome Archery Tips", headline: "Kanye West's Top 6", rating: 3)
        user_10.reviews.create(book: potter, body: "That Make Plumbers Nervous", headline: "Horrible Secrets", rating: 3)
        user_11.reviews.create(book: potter, body: "Tips From Jay-Z", headline: "Sexy Speed Skating", rating: 3)
        user_14.reviews.create(book: potter, body: "About Soldering", headline: "The Embarassing Truth", rating: 3)
        user_7.reviews.create(book: mockingbird, body: "CEOs Write In Their Journals", headline: "Hilarious Truths", rating: 2)
        user_8.reviews.create(book: mockingbird, body: "David Wichmann's 10 Amazing Halo Tips", headline: "UnitedHealth CEO", rating: 2)
        user_10.reviews.create(book: mockingbird, body: "Tips From AT&T CEO Randall L. Stephenson", headline: "Big Wave Surfing", rating: 2)
        user_15.reviews.create(book: mockingbird, body: "Your Doctor Is Using Against You", headline: "Unbelievable Facts", rating: 2)
        user_12.reviews.create(book: mockingbird, body: "Make Therapists Afraid", headline: "Secrets That", rating: 2)
        user_14.reviews.create(book: mockingbird, body: "Make Your Contractor Feel Sexually Confused", headline: "5 Things That Will", rating: 2)
        user_13.reviews.create(book: pride, body: "Save Papercraft?", headline: "Will William Shatner", rating: 6)
        user_8.reviews.create(book: pride, body: "Physicians Won't Admit", headline: "Amazing Truths", rating: 6)
        user_11.reviews.create(book: pride, body: "Boyfriends Eat More Vegetables", headline: "Secrets That Make", rating: 6)
        user_12.reviews.create(book: pride, body: "12 Shocking Tree Pruning Tips", headline: "Arnold Schwarzenegger's", rating: 6)
        user_16.reviews.create(book: pride, body: "From Bill Gates", headline: "Leaf Blowing Secrets", rating: 6)
        user_17.reviews.create(book: pride, body: "Family Doctors Don't Like To Think About", headline: "Mind-Blowing Secrets", rating: 6)
        user_7.reviews.create(book: narnia, body: "That Will Make Your Neighbor Angry", headline: "Jaw-Dropping Things", rating: 7)
        user_13.reviews.create(book: narnia, body: "That Make Attorneys Feel Aroused", headline: "Surprising Facts", rating: 7)
        user_9.reviews.create(book: narnia, body: "About The ghost of Steve Jobs", headline: "The Alarming Truth", rating: 7)
        user_10.reviews.create(book: narnia, body: "Top 20 Javascript Tips", headline: "Will Smith's", rating: 7)
        user_12.reviews.create(book: narnia, body: "Publicist Is Hiding From You", headline: "Truths Your", rating: 7)
        user_17.reviews.create(book: narnia, body: "Your Proctologist Gets Choked Up About", headline: "Terrifying Things", rating: 7)

        visit books_path
        within '#best-books' do
          expect(page).to have_content("The Chronicles of Narnia")      #Book titles and average rating
          expect(page).to have_content("Pride And Prejudice")      #Book titles and average rating
          expect(page).to have_content("An Astronaut's Guide to Life on Earth")      #Book titles and average rating

          expect(page).to_not have_content("The Hunger Games")
        end
      end

      it "displays three worst-rated books (book title)" do
        astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
        css = Book.create(title: 'CSSucks', pages: 420, year: 2019, cover_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')
        hunger = Book.create(title: 'The Hunger Games', pages: 374, year: 2008, cover_url: 'https://images.gr-assets.com/books/1447303603l/2767052.jpg')
        potter = Book.create(title: 'Harry Potter and the Order of the Phoenix', pages: 870, year: 2003, cover_url: 'https://images.gr-assets.com/books/1546910265l/2.jpg')
        mockingbird = Book.create(title: 'To Kill a Mockingbird', pages: 324, year: 1960, cover_url: 'https://images.gr-assets.com/books/1552035043l/2657.jpg')
        pride = Book.create(title: 'Pride And Prejudice', pages: 279, year: 1813, cover_url: 'https://images.gr-assets.com/books/1320399351l/1885.jpg')
        narnia = Book.create(title: 'The Chronicles of Narnia', pages: 767, year: 1956, cover_url: 'https://images.gr-assets.com/books/1449868701l/11127.jpg')

        user_1 = User.create(username: "Snozzlebert Chesterfield")
        user_2 = User.create(username: "Snorkeldink Crumplehorn")
        user_3 = User.create(username: "Fiddlestick Calldispatch")
        user_4 = User.create(username: "Bumblebee Cankersore")
        user_5 = User.create(username: "Brendadirk Curdlesnoot")
        user_6 = User.create(username: "Bedlington Cankersnuff")
        user_7 = User.create(username: "Beetlejuice Cragglethatch")
        user_8 = User.create(username: "Buckingham Creamsicle")
        user_9 = User.create(username: "Burlington Anglerfish")
        user_10 = User.create(username: "Bandicoot Crackerdog")
        user_11 = User.create(username: "Botany Chuckecheese")
        user_12 = User.create(username: "Benadryl Custardbath")
        user_13 = User.create(username: "Rinkydink Rainbowfish")
        user_14 = User.create(username: "Birdbox Bandersnatch")
        user_15 = User.create(username: "Whippersnitch Cottagecheese")
        user_16 = User.create(username: "Beezlebub Banglesnatch")
        user_17 = User.create(username: "Cadbury Bonaparte")

        astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
        css.authors << Author.find_or_create_by(name: 'Matt Weiss')
        hunger.authors << Author.find_or_create_by(name: 'Suzanne Collins')
        potter.authors << Author.find_or_create_by(name: 'J.K. Rowling')
        mockingbird.authors << Author.find_or_create_by(name: 'Harper Lee')
        pride.authors << Author.find_or_create_by(name: 'Jane Austen')
        pride.authors << Author.find_or_create_by(name: 'Anna Quindlen')
        narnia.authors << Author.find_or_create_by(name: 'C.S. Lewis')
        narnia.authors << Author.find_or_create_by(name: 'Pauline Baynes')

        user_2.reviews.create(book: astronaut, body: "I have so many good things to say about this book I don't think they'll all fit into one review (for my full review, including my four-year-old's reaction to it, please visit my blog, Cozy Little Book Journal).", headline: 'I have so many good things to say about this book', rating: 5)
        user_3.reviews.create(book: astronaut, body: "Have you ever wanted to know the life of an astronaut? How do you even get to be one? What do they do, especially when on earth? Why do they even do it? And how do you combine that with having a family? This wonderful new book will tell you all about it.", headline: 'Have you ever wanted to know the life of an astronaut?', rating: 5)
        user_1.reviews.create(book: astronaut, body: 'I hate space for some reason', headline: 'Boo Space', rating: 5)
        user_4.reviews.create(book: astronaut, body: 'I also hate space for some reason', headline: 'Boo Space2', rating: 5)
        user_5.reviews.create(book: astronaut, body: 'That was way more exciting', headline: "Wasn't The Martian based on a true story?", rating: 5)
        user_6.reviews.create(book: astronaut, body: 'I guess they can if you take videos and post them on youtube', headline: 'In space, no one can hear you play guitar', rating: 5)
        user_2.reviews.create(book: css, body: "Make Your Psychiatrist Go To The Gym More", headline: "Scary Truths That Will", rating: 1)
        user_7.reviews.create(book: css, body: "Agriculture Secretary Thomas J. Vilsack", headline: "Photoshop Tips From", rating: 1)
        user_8.reviews.create(book: css, body: "Keep To Themselves", headline: "Secrets Accountants", rating: 1)
        user_9.reviews.create(book: css, body: "6 Practical Beard Care Tips", headline: "Scarlett Johansson's", rating: 1)
        user_10.reviews.create(book: css, body: "Ernest Moniz Save Skin Care?", headline: "Will Energy Secretary", rating: 1)
        user_15.reviews.create(book: css, body: "Thinks About In The Bathroom", headline: "Facts Your Elected Official", rating: 1)
        user_2.reviews.create(book: hunger, body: "Secrets From Batman", headline: "Hilarious Dental Care", rating: 4)
        user_13.reviews.create(book: hunger, body: "Make Psychologists Feel Ashamed", headline: "Shocking Things That", rating: 4)
        user_8.reviews.create(book: hunger, body: "Your Web Designer Feel More Attractive", headline: "Incredible Facts That Will Make", rating: 4)
        user_10.reviews.create(book: hunger, body: "Receptionists Won't Tell Their Friends", headline: "Staggering Things", rating: 4)
        user_11.reviews.create(book: hunger, body: "Save Trumpet Playing?", headline: "Can Martin Scorsese", rating: 4)
        user_12.reviews.create(book: hunger, body: "Surprising Metallurgy Secrets", headline: "Ashton Kutcher's 15", rating: 4)
        user_7.reviews.create(book: potter, body: "Your Senator Will Never Learn", headline: "Troubling Truths", rating: 3)
        user_13.reviews.create(book: potter, body: "About Lady Gaga", headline: "Scandalous Truths", rating: 3)
        user_9.reviews.create(book: potter, body: "Awesome Archery Tips", headline: "Kanye West's Top 6", rating: 3)
        user_10.reviews.create(book: potter, body: "That Make Plumbers Nervous", headline: "Horrible Secrets", rating: 3)
        user_11.reviews.create(book: potter, body: "Tips From Jay-Z", headline: "Sexy Speed Skating", rating: 3)
        user_14.reviews.create(book: potter, body: "About Soldering", headline: "The Embarassing Truth", rating: 3)
        user_7.reviews.create(book: mockingbird, body: "CEOs Write In Their Journals", headline: "Hilarious Truths", rating: 2)
        user_8.reviews.create(book: mockingbird, body: "David Wichmann's 10 Amazing Halo Tips", headline: "UnitedHealth CEO", rating: 2)
        user_10.reviews.create(book: mockingbird, body: "Tips From AT&T CEO Randall L. Stephenson", headline: "Big Wave Surfing", rating: 2)
        user_15.reviews.create(book: mockingbird, body: "Your Doctor Is Using Against You", headline: "Unbelievable Facts", rating: 2)
        user_12.reviews.create(book: mockingbird, body: "Make Therapists Afraid", headline: "Secrets That", rating: 2)
        user_14.reviews.create(book: mockingbird, body: "Make Your Contractor Feel Sexually Confused", headline: "5 Things That Will", rating: 2)
        user_13.reviews.create(book: pride, body: "Save Papercraft?", headline: "Will William Shatner", rating: 6)
        user_8.reviews.create(book: pride, body: "Physicians Won't Admit", headline: "Amazing Truths", rating: 6)
        user_11.reviews.create(book: pride, body: "Boyfriends Eat More Vegetables", headline: "Secrets That Make", rating: 6)
        user_12.reviews.create(book: pride, body: "12 Shocking Tree Pruning Tips", headline: "Arnold Schwarzenegger's", rating: 6)
        user_16.reviews.create(book: pride, body: "From Bill Gates", headline: "Leaf Blowing Secrets", rating: 6)
        user_17.reviews.create(book: pride, body: "Family Doctors Don't Like To Think About", headline: "Mind-Blowing Secrets", rating: 6)
        user_7.reviews.create(book: narnia, body: "That Will Make Your Neighbor Angry", headline: "Jaw-Dropping Things", rating: 7)
        user_13.reviews.create(book: narnia, body: "That Make Attorneys Feel Aroused", headline: "Surprising Facts", rating: 7)
        user_9.reviews.create(book: narnia, body: "About The ghost of Steve Jobs", headline: "The Alarming Truth", rating: 7)
        user_10.reviews.create(book: narnia, body: "Top 20 Javascript Tips", headline: "Will Smith's", rating: 7)
        user_12.reviews.create(book: narnia, body: "Publicist Is Hiding From You", headline: "Truths Your", rating: 7)
        user_17.reviews.create(book: narnia, body: "Your Proctologist Gets Choked Up About", headline: "Terrifying Things", rating: 7)

        visit books_path

        within '#worst-books' do
          expect(page).to have_content("CSSucks")      #Book titles and average rating
          expect(page).to have_content("To Kill a Mockingbird")      #Book titles and average rating
          expect(page).to have_content("Harry Potter and the Order of the Phoenix")      #Book titles and average rating

          expect(page).to_not have_content("The Hunger Games")
        end
      end

      it "displays three reviewers with most comments" do
        astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
        css = Book.create(title: 'CSSucks', pages: 420, year: 2019, cover_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')
        hunger = Book.create(title: 'The Hunger Games', pages: 374, year: 2008, cover_url: 'https://images.gr-assets.com/books/1447303603l/2767052.jpg')
        potter = Book.create(title: 'Harry Potter and the Order of the Phoenix', pages: 870, year: 2003, cover_url: 'https://images.gr-assets.com/books/1546910265l/2.jpg')
        mockingbird = Book.create(title: 'To Kill a Mockingbird', pages: 324, year: 1960, cover_url: 'https://images.gr-assets.com/books/1552035043l/2657.jpg')
        pride = Book.create(title: 'Pride And Prejudice', pages: 279, year: 1813, cover_url: 'https://images.gr-assets.com/books/1320399351l/1885.jpg')
        narnia = Book.create(title: 'The Chronicles of Narnia', pages: 767, year: 1956, cover_url: 'https://images.gr-assets.com/books/1449868701l/11127.jpg')

        user_1 = User.create(username: "Snozzlebert Chesterfield")
        user_2 = User.create(username: "Snorkeldink Crumplehorn")
        user_3 = User.create(username: "Fiddlestick Calldispatch")
        user_4 = User.create(username: "Bumblebee Cankersore")
        user_5 = User.create(username: "Brendadirk Curdlesnoot")
        user_6 = User.create(username: "Bedlington Cankersnuff")

        astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
        css.authors << Author.find_or_create_by(name: 'Matt Weiss')
        hunger.authors << Author.find_or_create_by(name: 'Suzanne Collins')
        potter.authors << Author.find_or_create_by(name: 'J.K. Rowling')
        mockingbird.authors << Author.find_or_create_by(name: 'Harper Lee')
        pride.authors << Author.find_or_create_by(name: 'Jane Austen')
        pride.authors << Author.find_or_create_by(name: 'Anna Quindlen')
        narnia.authors << Author.find_or_create_by(name: 'C.S. Lewis')
        narnia.authors << Author.find_or_create_by(name: 'Pauline Baynes')

        user_1.reviews.create(book: astronaut, body: "I have so many good things to say about this book I don't think they'll all fit into one review (for my full review, including my four-year-old's reaction to it, please visit my blog, Cozy Little Book Journal).", headline: 'I have so many good things to say about this book', rating: 5)
        user_2.reviews.create(book: astronaut, body: "Have you ever wanted to know the life of an astronaut? How do you even get to be one? What do they do, especially when on earth? Why do they even do it? And how do you combine that with having a family? This wonderful new book will tell you all about it.", headline: 'Have you ever wanted to know the life of an astronaut?', rating: 5)
        user_3.reviews.create(book: astronaut, body: 'I hate space for some reason', headline: 'Boo Space', rating: 5)
        user_4.reviews.create(book: astronaut, body: 'I also hate space for some reason', headline: 'Boo Space2', rating: 5)
        user_5.reviews.create(book: astronaut, body: 'That was way more exciting', headline: "Wasn't The Martian based on a true story?", rating: 5)
        user_6.reviews.create(book: astronaut, body: 'I guess they can if you take videos and post them on youtube', headline: 'In space, no one can hear you play guitar', rating: 5)
        user_1.reviews.create(book: css, body: "Make Your Psychiatrist Go To The Gym More", headline: "Scary Truths That Will", rating: 1)
        user_2.reviews.create(book: css, body: "Agriculture Secretary Thomas J. Vilsack", headline: "Photoshop Tips From", rating: 1)
        user_3.reviews.create(book: css, body: "Keep To Themselves", headline: "Secrets Accountants", rating: 1)
        user_4.reviews.create(book: css, body: "6 Practical Beard Care Tips", headline: "Scarlett Johansson's", rating: 1)
        user_5.reviews.create(book: css, body: "Ernest Moniz Save Skin Care?", headline: "Will Energy Secretary", rating: 1)
        user_1.reviews.create(book: hunger, body: "Secrets From Batman", headline: "Hilarious Dental Care", rating: 4)
        user_2.reviews.create(book: hunger, body: "Make Psychologists Feel Ashamed", headline: "Shocking Things That", rating: 4)
        user_3.reviews.create(book: hunger, body: "Your Web Designer Feel More Attractive", headline: "Incredible Facts That Will Make", rating: 4)
        user_4.reviews.create(book: hunger, body: "Receptionists Won't Tell Their Friends", headline: "Staggering Things", rating: 4)
        user_1.reviews.create(book: potter, body: "Your Senator Will Never Learn", headline: "Troubling Truths", rating: 3)
        user_2.reviews.create(book: potter, body: "About Lady Gaga", headline: "Scandalous Truths", rating: 3)
        user_3.reviews.create(book: potter, body: "Awesome Archery Tips", headline: "Kanye West's Top 6", rating: 3)
        user_4.reviews.create(book: potter, body: "That Make Plumbers Nervous", headline: "Horrible Secrets", rating: 3)
        user_1.reviews.create(book: mockingbird, body: "CEOs Write In Their Journals", headline: "Hilarious Truths", rating: 2)
        user_2.reviews.create(book: mockingbird, body: "David Wichmann's 10 Amazing Halo Tips", headline: "UnitedHealth CEO", rating: 2)
        user_3.reviews.create(book: mockingbird, body: "Tips From AT&T CEO Randall L. Stephenson", headline: "Big Wave Surfing", rating: 2)
        user_1.reviews.create(book: pride, body: "Save Papercraft?", headline: "Will William Shatner", rating: 6)
        user_2.reviews.create(book: pride, body: "Physicians Won't Admit", headline: "Amazing Truths", rating: 6)
        user_1.reviews.create(book: narnia, body: "That Will Make Your Neighbor Angry", headline: "Jaw-Dropping Things", rating: 7)

        visit books_path

        within '#top-three-users' do
          expect(page).to have_content(user_1.username)
          expect(page).to have_content(user_2.username)
          expect(page).to have_content(user_3.username)

          expect(page).to_not have_content(user_4.username)
        end
      end

      it "displays author name as link" do
        astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
        astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')

        visit books_path

        expect(page).to have_link(astronaut.authors[0].name)
      end
    end
  end
end
