# ZSSN (Zombie Survival Social Network)

This project follows the [rules and terms](https://github.com/LukasTsunami/ZSSN/wiki/Projects-Definition) from [Codeminer42](https://www.codeminer42.com/) backend test that I applied.

## Project Setup and answering some Questions:

### How is the project going?
  * It isn't finished yet, but everything it already haves its described bellow:

### How to run the project?   
* First you need to have docker and docker-compose commands installed in your machine   
After that, there are some commands you need to run before running project:   
``docker-compose build``   
``docker-compoe up -d``   
``docker-compose exec web bundle install``   
``docker-compose exec web rails db:create``   
``docker-compose exec web rails db:migrate``  

### How can I run the tests?    
``docker-compose exec web rspec``   

### How can I see Simplecode's code coverage report?
open at browser the file at ./coderage/index.html   
     
### How can I see project running?
Unfortunently the project is not consumable yet. It only have the tests suite passing    
    
### But, how can I see, what you did in this project?   
Weel, I will try to explain what was did and what I was thinking in doing that this like that

## The project:
* First, everything I made is in domain layer. After that I would need to implement at service layer to, in order to take requests and calls domain object rules to apply those features:   
### Add survivors to the database:
* I can save survivors on database with the Survivor model. 
* I already made its persistance validation too. It is on SurvivorValidator which is a Concern extracting every validation to survivo's model persistance
 
### A survivor also must have an inventory:
* Survivor have an inventory of items, and can access them directly by has through association or by inventory and after items

### Survivors cannot Add/Remove items from inventory    
* I followed the CQRS principle: separating command (update and delete) from queries (to ease, I didn't make it readonly, I used before update callback to avoid it to be updated)    
* Survivors have access to the QueryInventory class, witch have access only in be created and list, filter and search items on inventory. At this way a survivor cannot change it inventory directly.   
   
### A survivor is marked as infected when at least three other survivors report their contamination.
* I used a state machine to manage survivor contamination reports, which, calling the same method, I could change its state.
* I used AASM gem to help with this feature  
* After the third report, there is called a callback that **flags survivor as infected**

### When a survivor is infected, his/her inventory items become inaccessible (they cannot trade with others).     
* In order to resolve this, I made an Observer, which looks for survivor's infection and where it happens, it goes and change its inventory items state to infected too, with this, they became losed.     
     
# [FUTURE THINGS]Trading items - A layered system workflow     
* I'm already doing this feature, 'Cause this I'll only tell how is my work in planning:     
     
## Application Layer     
### Mainly, it have four responsibilities: Take requests, filter them, delegate them to service, respond back to client     
* It is responsible to gets client request and perform some actions in it before send it to Service Layer     
  - Validate request params with strong params     
  - Break url in to pieces that it can get the filters, pagination, order, relashionship filters and content negociation along it and knows exactly what the client needs     
  - Calls a DataMapper which will map the request in a Data Transfer Object (DTO), with only the required data.     
  - Delegate to the proper part the request with DTO. There is a service for each request domain.     
* Respond back to clients     
  - It gets a DTO and passes to the proper one Sanitizer     
  - Sanitizer maps DTO to a JSON Object     
  - Application Layer send response back to client     
  
## Service Layer     
* It receives the request and DTO from Application and start to do what is responsible:     
### TradeWorkflow     
* In trade workflow, we have a TradeManager, that follows the Chain of Responsability Pattern, and chains all the workflow steps together to abstract as much transfer logic as it can.     
#### The chain nodes (Handlers) in workflow:   
* Existance Analyzer:  
  - It analyze if both users exist   
  - It analyze if the items both declared, exists too   
* Equivalence Analyzer:   
  - It analyze if both sides of transaction gave the same amount of points   
* Unit of Work:   
  - It is responsible to do the trade and ensure that the trade was did successfully.   
  - It have three parts:  Unit, Memento and Worker 
* [Unit of Work] Unit   
  - It ensure the flow amoung the other two pieces   
* [Unit of Work] Memento    
  - It saves the state of both survivors inventory before doing the trade   
  - If something goes wrong it can rollback the transaction and restore old inventory state   
* [Unit of Work] Worker   
  - Its who executes the trade between both users   
  - It uses the CommandInventory in order to update inventory    
* Publiher:   
  - It publishes a successfully transactions in a channel, to everyone that would want to know about it   
* Organizer:   
  - It map a DTO answer to give back to ApplicationLayer   
     
### ApplicationLayer (The Back):     
  - Receives a DTO and sends it to a Sanitizer which will take DTO and Map to a JSON Object      
  - Respond back to client     
     
### What happens when something breaks?     
  - There is a **Bad News Counter**, which will map a DTO answer to give send back to client     
  - This DTO answer also goes through Sanitizer to a JSON Mapping     
  - All handlers knows about Bad News Counter when inherits from BaseHandler     
      
That's it, trade workflow its mapped   
     
.     
     
_Lets talk about other services (All of them responds with a DTO and it is managed by Sanitizer)_     
     
## InfectionService     
### In infection service we have two nested services: ReportInfectedSurvivor and InfectedReports     
* ReportInfectedSurvivor: 
  - Report a survivor as infected     
  - It will call the report_as_infected! of Survivor object     
* InfectedReports: 
  - Getting reports about infected things     
  - It will call the proper domain object to respond back right answer     
      
## SurvivorDataManagerService     
### It is responsable for update survivor data and knowing about which data connot be updated     
     
.     
     
## Gems that I want to use to improve this project:   
* JSONAPI::Resources        
  - For handling with filters, ordering and relashionships in requests       
  - [URL]= https://github.com/cerebris/jsonapi-resources        
* Periscope     
  - For handling requests using model scopes     
  - [URL]= https://github.com/laserlemon/periscope     
     
## Gems already being used in this project:     
* Rspec-rails     
  - For test handling using a Spec DSL     
  - [URL]= https://github.com/rspec/rspec-rails     
* AASM     
  - For managing survivor infection reports state machine     
  - [URL]= https://github.com/aasm/aasm     
* Everett     
  - For using observers in Rails 5     
  - [URL]= https://github.com/yasaichi/everett     
* Pry     
  - For a better debbug in code     
  - [URL]= https://github.com/pry/pry     
* Factory Bot Rails     
  - For creating objects using factories faster and using Traits     
  - [URL]= https://github.com/thoughtbot/factory_bot_rails     
* Faker     
  - For creating factories with Organized random data     
  - [URL]= https://github.com/faker-ruby/faker     
* Shoulda Matchers     
  - For using better validator matchers in testing     
  - [URL]= https://github.com/thoughtbot/shoulda-matchers     
* Shoulda Matchers Callback     
  - For testing callbacks, mainly model callbacks     
  - [URL]= https://github.com/jdliss/shoulda-callback-matchers     
* Simplecov     
  - For test coverage of project     
  - [URL]= https://github.com/colszowka/simplecov     
* Rubocop     
  - For project best pratices code analyze and formatting     
  - [URL]= https://github.com/rubocop-hq/rubocop/     
