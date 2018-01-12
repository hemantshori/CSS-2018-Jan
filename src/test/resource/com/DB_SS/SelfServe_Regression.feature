@all
Feature: Regression for SelfServePortal

  @review
  Scenario Outline: Check that the DB Results Website can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | SelfServePortal" page
    Then I see text "Delivering an excellent customer experience will grow and retain customers and reduce costs. Engaging with your customers is easy with SelfServePortal." displayed

    Examples: 
      | PortalName    |
      | SelfServeTEST |

  @review
  Scenario Outline: Check that all buttons and links on the Homepage work as intended
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | SelfServePortal" page
    Then I see text "Delivering an excellent customer experience will grow and retain customers and reduce costs. Engaging with your customers is easy with SelfServePortal." displayed
    Then I scroll down by "<Factor>" percent
    Then I click on "<Link>"
    Then I check I am on "<PageTitle>" page

    Examples: 
      | PortalName    | Factor | Link                 | PageTitle                            |
      | SelfServeTEST |      0 | ABOUT US             | About Us                             |
      | SelfServeTEST |     20 | View our Products    | Products                             |
      | SelfServeTEST |     40 | More on this benefit | Cost Effective Customer Self Service |
      | SelfServeTEST |     45 | all benefits         | Benefits                             |
      | SelfServeTEST |    100 | Privacy              | Privacy                              |
      | SelfServeTEST |    100 | Terms of Use         | Terms of Use                         |

  @review
  Scenario Outline: Check that the Get in Touch form is workign as intended
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | SelfServePortal" page
    Then I see text "Delivering an excellent customer experience will grow and retain customers and reduce costs. Engaging with your customers is easy with SelfServePortal." displayed
    Then I scroll down by "4500" percent
    Then I see text "Get in touch" displayed
    Then I see text "Want to know more about how SelfServePortal will increase your customer engagement?" displayed
    Then I click on "submit"
    Then I see text "* Please fill in the mandatory fields" displayed
    And I enter the details as
      | Fields              | Value |
      | ContactForm_Name    | TEST  |
      | ContactForm_Email   | TEST  |
      | ContactForm_Message | TEST  |
      | ContactForm_Company | TEST  |
      | ContactForm_Phone   |     1 |
    Then I click on "submit"
    Then I see text "* Please enter a valid email" displayed
    And I enter the details as
      | Fields              | Value         |
      | ContactForm_Name    | TEST          |
      | ContactForm_Email   | TEST@TEST.com |
      | ContactForm_Message | TEST          |
      | ContactForm_Company | TEST          |
      | ContactForm_Phone   |             1 |
    Then I click on "submit"
    Then I see text "Your message has been sent. We'll be in touch soon." displayed
    Then I see text "* Please enter a valid email" not displayed

    Examples: 
      | PortalName    |
      | SelfServeTEST |

  @review
  Scenario Outline: Check that Newsroom articles can be accessed
    Given I want to login to portal "<PortalName>"
    Then I click on "<Link>"
    Then I check I am on "<PageTitle>" page
    Then I see text "Newsroom" displayed
    Then I see text "Keep up to date with the latest news at SelfServePortal" displayed
    Then I scroll down by "<Factor>" percent
    And I click "<BName>" regarding DB topic "<Topic>"
    #Then I click on object with xpath "//*[contains(text(), '<Topic>')]/..//a[contains(text(), 'Read MORE')]"
    Then I see text "<Topic>" displayed

    Examples: 
      | PortalName    | Link     | PageTitle | Topic                                                  | BName     | Factor |
      | SelfServeTEST | Newsroom | Newsroom  | DB Results showcases SelfServe Portal to the US market | Read MORE |      0 |
      | SelfServeTEST | Newsroom | Newsroom  | SelfServePortal reveals its digital roadmap            | Read MORE |     20 |
      | SelfServeTEST | Newsroom | Newsroom  | SelfServePortal ends bill shock for consumers          | Read MORE |     30 |

  @wip
  Scenario Outline: Check that Product page can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | SelfServePortal" page
    Then I see text "Delivering an excellent customer experience will grow and retain customers and reduce costs. Engaging with your customers is easy with SelfServePortal." displayed
    Then I hover over "Products" and click on "Taxation"
    Then I check I am on "Product - Tax" page
    Then I see text "Tax Customer SelfServe™  Portal" displayed
    Then I scroll down by "20" percent
    Then I see text "Tax and revenue collection organisations around the world are seeking to reap the benefits from transforming their organisation with digital technology." displayed
    Then I scroll down by "30" percent
    Then I wait for "2000" millisecond
    Then I check "video_content" exists

    Examples: 
      | PortalName    |
      | SelfServeTEST |

  @review
  Scenario Outline: Check that Utilities page can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | SelfServePortal" page
    Then I see text "Delivering an excellent customer experience will grow and retain customers and reduce costs. Engaging with your customers is easy with SelfServePortal." displayed
    Then I hover over "Products" and click on "Utilities"
    Then I check I am on "Product - Utilities" page
    Then I see text "Utilities Customer SelfServe™  Portal" displayed
    Then I scroll down by "20" percent
    Then I see text "SelfServe™ Portal for Utilities is designed to give you everything you need to connect with your customers, from bill and usage history to payment and contact details, all in one place and available anytime from any device." displayed

    Examples: 
      | PortalName    |
      | SelfServeTEST |

  @review
  Scenario Outline: Check that Benefit page exists and its articles can be accessed
    Given I want to login to portal "<PortalName>"
    Then I click on "Benefits"
    Then I check I am on "Benefits" page
    Then I see text "Our Benefits" displayed
    Then I see text "Seamless integration with your existing systems delivering more for your customers." displayed
    Then I scroll down by "<Factor>" percent
    And I click "<BName>" regarding DB topic "<Topic>"
    #Then I click on object with xpath "//*[contains(text(), '<Topic>')]/..//a[contains(text(), 'Read MORE')]"
    Then I see text "<Topic>" displayed

    Examples: 
      | PortalName    | Link     | PageTitle | Topic                                         | BName      | Factor |
      | SelfServeTEST | Newsroom | Newsroom  | Cost Effective Customer Self Service          | LEARN MORE |      0 |
      | SelfServeTEST | Newsroom | Newsroom  | Customer Engagement                           | LEARN MORE |     20 |
      | SelfServeTEST | Newsroom | Newsroom  | Interactive, Data Rich Experience             | LEARN MORE |     30 |
      | SelfServeTEST | Newsroom | Newsroom  | SelfServePortal Ends Bill Shock for Consumers | LEARN MORE |     30 |

  @review
  Scenario Outline: Check that About Us page exists
    Given I want to login to portal "<PortalName>"
    Then I click on "About Us"
    Then I check I am on "About Us" page
    Then I see text "About Us" displayed
    Then I see text "Global leader in provision of solutions to empower Customers." displayed

    Examples: 
      | PortalName    |
      | SelfServeTEST |

  @review
  Scenario Outline: Check that Partners page exists
    Given I want to login to portal "<PortalName>"
    Then I click on "Partners"
    Then I check I am on "Partners" page
    Then I see text "Partners" displayed
    Then I see text "SelfServePortal has developed strategic alliances with partners who share our values, innovativeness and drive for customer satisfaction." displayed

    Examples: 
      | PortalName    |
      | SelfServeTEST |

      
 @review
  Scenario Outline: Check that Support Policy page can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | SelfServePortal" page
    Then I see text "Delivering an excellent customer experience will grow and retain customers and reduce costs. Engaging with your customers is easy with SelfServePortal." displayed
		Then I hover over "Support" and click on "Support Policy"
		Then I check I am on "Support Policy" page
		Then I see text "Support Policy" displayed

    Examples: 
      | PortalName    |
      | SelfServeTEST |
      
      
 @review
  Scenario Outline: Check that Configuration Requirements page can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | SelfServePortal" page
    Then I see text "Delivering an excellent customer experience will grow and retain customers and reduce costs. Engaging with your customers is easy with SelfServePortal." displayed
		Then I hover over "Support" and click on "Configuration Requirements"
		Then I check I am on "Configuration Requirements" page
		Then I see text "Configuration Requirements" displayed

    Examples: 
      | PortalName    |
      | SelfServeTEST |
      
      
    @review
  Scenario Outline: Check that Careers page can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | SelfServePortal" page
    Then I see text "Delivering an excellent customer experience will grow and retain customers and reduce costs. Engaging with your customers is easy with SelfServePortal." displayed
		Then I click on "Careers"
		Then I check I am on "Careers" page
		Then I see text "Careers" displayed
		Then I see text "A career with SelfServePortal" displayed
		

    Examples: 
      | PortalName    |
      | SelfServeTEST |
   
	@review
  Scenario Outline: Check that Contact page can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | SelfServePortal" page
    Then I see text "Delivering an excellent customer experience will grow and retain customers and reduce costs. Engaging with your customers is easy with SelfServePortal." displayed
		Then I click on "Contact"
		Then I check I am on "Contact" page
		Then I see text "Contact Us" displayed
		Then I see text "Contact SelfServePortal to learn how we can help empower your customers." displayed
		

    Examples: 
      | PortalName    |
      | SelfServeTEST |   


@review
  Scenario Outline: Check that Search Engine works
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | SelfServePortal" page
    Then I see text "Delivering an excellent customer experience will grow and retain customers and reduce costs. Engaging with your customers is easy with SelfServePortal." displayed
   # Then I hover over "Who We Are" and click on "About Us"
     Then I click on button "search-cse-button"
     And I enter the details as
      | Fields              | Value         |
      | search-text    | TEST          |
    And I click on button "MagnifyingGlass"
    Then I wait for "3000" millisecond
    Then I check I am on "SearchResults" page
    Then I see text "Terms of Use | SelfServePortal" displayed
   		
    Examples: 
      | PortalName |
      | SelfServeTEST     |
      