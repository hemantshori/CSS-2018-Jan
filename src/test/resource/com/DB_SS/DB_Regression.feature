@all
Feature: DB RESULTS TEST

  @review
  Scenario Outline: Check that the DB Results Website can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed

    Examples: 
      | PortalName |
      | DBTEST     |

  @review
  Scenario Outline: Check that all buttons and links on the Homepage work as intended
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I scroll down by "<Factor>" percent
    Then I click on "<Link>"
    Then I check I am on "<PageTitle>" page

    Examples: 
      | PortalName | Factor | Link                 | PageTitle                                                                                     |
      | DBTEST     |     50 | More on this project | Case Study - A strategy for Power of Choice keeps a Victorian electricity company competitive |
      | DBTEST     |     10 | ABOUT US             | About Us                                                                                      |
      | DBTEST     |     40 | View our services    | Services                                                                                      |
      | DBTEST     |     66 | all projects         | Projects                                                                                      |

  @review
  Scenario Outline: Check that all footer links are working as intended
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I scroll down by "100" percent
    Then I click on "<Link>"
    Then I check I am on "<PageTitle>" page

    Examples: 
      | PortalName | Factor | Link         | PageTitle    |
      | DBTEST     |     50 | Privacy      | Privacy      |
      | DBTEST     |     10 | Terms of Use | Terms of Use |

  @review
  Scenario Outline: Check that footer icons are working as intended
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I scroll down by "100" percent
    Then I click on object with xpath "//*[contains(@class, 'footer-container')]//div//div"
    Then I click on image with filename "<FileName>"
    Then I wait for "3000" millisecond
    Then a new page "<URL>" is launched

    Examples: 
      | PortalName | FileName         | URL                                          |
      | DBTEST     | youtube_icon.png  | https://www.youtube.com/channel/UCAKgHhVbAXYipv0wda6gmlQ               |
      
      #For some reason, you can't find these icons with xpaths
      #| DBTEST     | twittericon.png  | https://twitter.com/_dbresults               |
      #| DBTEST     | linkedinicon.png | https://www.linkedin.com/company/db-results/ |

  @review
  Scenario Outline: Check that the Get in Touch form is workign as intended
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I scroll down by "90" percent
    Then I see text "Get in touch" displayed
    Then I see text "If you would like to know more about how DB Results can help your business please get in touch" displayed
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
      | PortalName |
      | DBTEST     |

  @review
  Scenario Outline: Check that the Newsroom page can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I click on "<Link>"
    Then I check I am on "<PageTitle>" page

    Examples: 
      | PortalName | Link     | PageTitle |
      | DBTEST     | Newsroom | Newsroom  |

  @review
  Scenario Outline: Check that Newsroom articles can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I click on "<Link>"
    Then I check I am on "<PageTitle>" page
    Then I scroll down by "<Factor>" percent
    And I click "<BName>" regarding DB topic "<Topic>"
    #Then I click on object with xpath "//*[contains(text(), '<Topic>')]/..//a[contains(text(), 'Read MORE')]"
    Then I see text "<Topic>" displayed

    Examples: 
      | PortalName | Link     | PageTitle | Topic                                                        | BName     | Factor |
      | DBTEST     | Newsroom | Newsroom  | HISA 2017 Don Walker Award Winner                            | Read MORE |      0 |
      | DBTEST     | Newsroom | Newsroom  | Securing Our Digital Future                                  | Read MORE |     20 |
      | DBTEST     | Newsroom | Newsroom  | AMY Awards - Highly Commended result to be proud of          | Read MORE |     30 |
      | DBTEST     | Newsroom | Newsroom  | Gartner names OutSystems as a High-Productivity aPaaS leader | Read MORE |     40 |

  @wip
  Scenario Outline: Check that Newsroom pagination works
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I click on "<Link>"
    Then I check I am on "<PageTitle>" page
    Then I scroll down by "50" percent
    Then I click on "2"
    Then I wait for "4000" millisecond
    Then I scroll down by "<Factor>" percent
    And I click "<BName>" regarding DB topic "<Topic>"
    #Then I click on object with xpath "//*[contains(text(), '<Topic>')]/..//a[contains(text(), 'Read MORE')]"
    Then I see text "<Topic>" displayed

    Examples: 
      | PortalName | Link     | PageTitle | Topic                                                                              | BName     | Factor |
      | DBTEST     | Newsroom | Newsroom  | Insights Into Digital Driven Behaviour Change                                      | Read MORE |      0 |
      | DBTEST     | Newsroom | Newsroom  | Global Digital Insights Series                                                     | Read MORE |     10 |
      | DBTEST     | Newsroom | Newsroom  | Farewell 2016!                                                                     | Read MORE |     20 |
      | DBTEST     | Newsroom | Newsroom  | DB Results leads successful Solution Integration for major AMI remediation program | Read MORE |     30 |

  @review
  Scenario Outline: Check that the 3plus3 page can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I hover over "What We Do" and click on "3plus3"
    Then I see text "You Know Why - We Know How" displayed
    Then I check "videoplaceholder" exists

    Examples: 
      | PortalName |
      | DBTEST     |

  @review
  Scenario Outline: Check that the Projects page can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I hover over "What We Do" and click on "Projects"
    Then I check I am on "Projects" page
    Then I see text "Our Projects" displayed
    Then I see text "We deliver through our range of strategy, consulting, digital, technology and operations services." displayed

    Examples: 
      | PortalName |
      | DBTEST     |

  @review
  Scenario Outline: Check that the Projects articles can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I hover over "What We Do" and click on "Projects"
    Then I check I am on "Projects" page
    Then I see text "Our Projects" displayed
    Then I see text "We deliver through our range of strategy, consulting, digital, technology and operations services." displayed
    Then I scroll down by "<Factor>" percent
    And I click "<BName>" regarding DB topic "<Topic>"
    Then I see text "<Topic>" displayed

    Examples: 
      | PortalName | Link     | PageTitle | Topic                                                                            | BName      | Factor |
      | DBTEST     | Newsroom | Newsroom  | DB Results wins ACT Revenue Office digital transformation project                | LEARN MORE |      5 |
      | DBTEST     | Newsroom | Newsroom  | A strategy for Power of Choice keeps a Victorian electricity company competitive | LEARN MORE |     10 |
      | DBTEST     | Newsroom | Newsroom  | First Australian implementation of new AASB15 accounting standards               | LEARN MORE |     20 |
      | DBTEST     | Newsroom | Newsroom  | Leading Industry Super Fund entrust digital solutions to DB Results              | LEARN MORE |     30 |

  @review
  Scenario Outline: Check that the Services page can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I hover over "What We Do" and click on "Services"
    Then I check I am on "Services" page
    Then I see text "Our Services" displayed
    Then I see text "We help shape your future and define how to get you there." displayed

    Examples: 
      | PortalName |
      | DBTEST     |

  @review
  Scenario Outline: Check that the Services articles can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I hover over "What We Do" and click on "Services"
    Then I check I am on "Services" page
    Then I see text "Our Services" displayed
    Then I see text "We help shape your future and define how to get you there." displayed
    Then I scroll down by "<Factor>" percent
    And I click "<BName>" regarding DB topic "<Topic>"
    Then I see text "<Topic>" displayed

    Examples: 
      | PortalName | Link     | PageTitle | Topic      | BName      | Factor |
      | DBTEST     | Newsroom | Newsroom  | Strategy   | LEARN MORE |      5 |
      | DBTEST     | Newsroom | Newsroom  | Consulting | LEARN MORE |     10 |
      | DBTEST     | Newsroom | Newsroom  | Digital    | LEARN MORE |     20 |
      | DBTEST     | Newsroom | Newsroom  | Technology | LEARN MORE |     30 |

  @review
  Scenario Outline: Check that the About Us page can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I hover over "Who We Are" and click on "About Us"
    Then I check I am on "About Us" page
    Then I see text "Helping organisations along every step of their digital transformation journey." displayed
    Then I see text "DB Results is a digital business consulting and technology company. We help your business move from strategy to reality." displayed

    Examples: 
      | PortalName |
      | DBTEST     |

  @review
  Scenario Outline: Check that the Partners page can be accessed and the images point to the correct link
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I hover over "Who We Are" and click on "Partners"
    Then I check I am on "Partners" page
    Then I see text "We partner to deliver disruptive technologies and services solutions to solve our customers' challenges" displayed
    Then I scroll down by "<Percent>" percent
    Then I click on link with URL "<URL>"
    Then I wait for "7000" millisecond
    Then a new page "<URL>" is launched

    Examples: 
      | PortalName | URL                                                             | Percent |
      | DBTEST     | https://www.outsystems.com/                                     |       0 |
      | DBTEST     | https://www.kloudgin.com/field-service-management-overview.html |       0 |
      | DBTEST     | https://www.oracle.com/au/index.html                            |       0 |
      | DBTEST     | http://www.sas.com/en_au/home.html                              |      20 |
      | DBTEST     | http://www.blueprintsys.com/                                    |      20 |
      | DBTEST     | https://www.inenergis.com/                                      |      30 |
      | DBTEST     | http://www.ge.com/digital/                                      |      30 |
      | DBTEST     | https://www.kentico.com/                                        |      30 |

  @review
  Scenario Outline: Check that the People page can be accessed and that the entries are present
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I hover over "Who We Are" and click on "People"
    Then I check I am on "People" page
    Then I see text "Our People" displayed
    Then I see text "Our modus operandi seeks to balance people, customers and quality to deliver your benefits" displayed
    Then I scroll down by "5" percent
    Then I check "wtsortcontainer" exists
    Then I click on object with xpath "(//*[contains(text(), 'Executive')])[2]"
    Then "<Item>" is displayed as "<ItemName>"
      | Item | ItemName      |
      | item | ANDREW DEAN   |
      | item | GAVIN BUNSHAW |
      | item | SALLY MCLEAN  |
      | item | JOHN DEMELIS  |
    # for some reason clicking this with the Chromedriver doesn't properly load the entries
    #Then I click on object with xpath "//a//*[contains(text(), 'Leadership')]"
    #Then "<Item>" is displayed as "<ItemName>"
    #| Item | ItemName          |
    #| item | DAMIAN WALSH      |
    #| item | BRENTON MCPHERSON |
    #| item | MATT NIDD         |
    #| item | PETER FAULKNER    |
    #| item | PHILIP HARTLEY    |
    #| item | TRACY KELLY       |
    #| item | JAMES COLUMBINE   |
    #| item | RICHARD JOHNS     |
    Then I click on object with xpath "(//*[contains(text(), 'All')])[2]"
    Then "<Item>" is displayed as "<ItemName>"
      | Item | ItemName          |
      | item | ANDREW DEAN       |
      | item | GAVIN BUNSHAW     |
      | item | SALLY MCLEAN      |
      | item | JOHN DEMELIS      |
      | item | DAMIAN WALSH      |
      | item | BRENTON MCPHERSON |
      | item | MATT NIDD         |
      | item | PETER FAULKNER    |

    Examples: 
      | PortalName |
      | DBTEST     |

  @review
  Scenario Outline: Check that the People Profile pages are working
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I hover over "Who We Are" and click on "People"
    Then I check I am on "People" page
    Then I see text "Our People" displayed
    Then I see text "Our modus operandi seeks to balance people, customers and quality to deliver your benefits" displayed
    Then I scroll down by "5" percent
    Then I check "wtsortcontainer" exists
    Then I click on button "peopleImage"
    Then I click on "View ANDREW DEAN's Profile"
    Then I check I am on "People Profile" page
    Then I see text "ANDREW DEAN" displayed
    Then I see text "CHIEF EXECUTIVE OFFICER" displayed
    Then I check "peopleImage" exists

    Examples: 
      | PortalName |
      | DBTEST     |

  @review
  Scenario Outline: Check that the DB Blog page can be accessed along with the entries
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I hover over "Who We Are" and click on "DB Blog"
    Then I check I am on "Our Blog" page
    Then I see text "DB Blog" displayed
    Then I see text "Our Thinking" displayed
    Then I scroll down by "<Factor>" percent
    Then I click on "<BlogTitle>"
    Then I check I am on "Blog Post - <BlogTitle>" page
    Then I check "peopleImage" exists
    Then I check "wtimageplaceholder" exists
    Then I see text "<Author>" displayed

    Examples: 
      | PortalName | BlogTitle                           | Author    | Factor |
      | DBTEST     | Moving Beyond the Commodity Utility | MATT NIDD |      0 |
      | DBTEST     | Insights into Cyber Attacks on Ukraine & IoT Security | GERALD XIE |      0 |
      | DBTEST     | Digitising the Customer Experience |BRIDGETTE BARRY-MURPHY|      5 |
      | DBTEST     | Staying relevant as a Utilities Retailer  | MATT NIDD |      10 |
      
    @review
  Scenario Outline: Check that the DB Blog pagination is working
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
    Then I hover over "Who We Are" and click on "DB Blog"
    Then I check I am on "Our Blog" page
    Then I see text "DB Blog" displayed
    Then I see text "Our Thinking" displayed
    Then I scroll down by "<Factor>" percent
    Then I click on "<BlogTitle>"
    Then I check I am on "Blog Post - <BlogTitle>" page
    Then I check "peopleImage" exists
    Then I check "wtimageplaceholder" exists
    Then I see text "<Author>" displayed

    Examples: 
      | PortalName | BlogTitle                           | Author    | Factor |
      | DBTEST     | Moving Beyond the Commodity Utility | MATT NIDD |      0 |
      | DBTEST     | Insights into Cyber Attacks on Ukraine & IoT Security | GERALD XIE |      0 |
      | DBTEST     | Digitising the Customer Experience |BRIDGETTE BARRY-MURPHY|      5 |
      | DBTEST     | Staying relevant as a Utilities Retailer  | MATT NIDD |      10 |
      
  
  
  @review
  Scenario Outline: Check that the Careers page can be accessed
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
   # Then I hover over "Who We Are" and click on "About Us"
    Then I click on "Careers"
    Then I check I am on "Careers" page
    Then I see text "A career with DB Results" displayed
    Then I see text "Join DB Results Agile Talent Community" displayed
		Then I scroll down by "50" percent
		Then I click on "Apply Now"
		Then I see text "Graduate program application" displayed
		Then I see text "To be eligible to apply, you must be able to legally work in Australia." displayed
    Examples: 
      | PortalName |
      | DBTEST     |
  
    @review
  Scenario Outline: Check that the Careers form works as expected
    Given I want to login to portal "<PortalName>"
    Then I click on "Careers"
    Then I check I am on "Careers" page
		Then I scroll down by "50" percent
		Then I click on "Apply Now"
		  And I enter the details as
      | Fields              | Value         |
      | GradForm_FirstName    | TEST          |
      | GradForm_LastName   | TEST |
      | GradForm_DateCompletion | 11111111          |
		Then I select "Melbourne" from "LocationDropdown"
		Then I click on button "GradForm_NotEligible"
		Then I click on button "GradForm_NotTravel"
		Then I scroll down by "4" percent
		 And I enter the details as
      | Fields              | Value         |
      | GradForm_VocationWork    | TEST          |
      | GradForm_Motivation   | TEST |
      | GradForm_Leadership | TEST          |
      | GradForm_DeadLines | TEST |
    Then I scroll down by "2" percent
    Then I click on "Submit your application"
    Then I wait for "2000" millisecond
    Then I see text "Date expected!" displayed
      And I enter the details as
      | Fields              | Value         |
      | GradForm_FirstName    | TEST          |
      | GradForm_LastName   | TEST |
      | GradForm_DateCompletion | 22/12/2016          |
      Then I click on button "GradForm_FirstName"
      Then I scroll down by "21" percent
       Then I click on "Submit your application"
    Then I wait for "2000" millisecond
    Then I see text "Required field" displayed
    Examples: 
      | PortalName |
      | DBTEST     |
  
	@review
  Scenario Outline: Check that the Contacts page
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
   # Then I hover over "Who We Are" and click on "About Us"
    Then I click on "Contact"
    Then I check I am on "Contact" page
    Then I see text "Contact Us" displayed
    Then I see text "Contact DB Results to learn how our consultants can help solve your business problems." displayed
    Then I see text "We provide strategy, consulting, digital, technology and operations services - especially in high demand areas such as organisational change, customer experience, analytics, billing and regulatory compliance." displayed
		Then I scroll down by "20" percent
		Then I click on "DB Results on Linkedin"
		Then a new page "https://www.linkedin.com/company/db-results" is launched
		
    Examples: 
      | PortalName |
      | DBTEST     |
      
@review
  Scenario Outline: Check that Search Engine works
    Given I want to login to portal "<PortalName>"
    Then I check I am on "Home | DB Results - Digital Business specialists" page
    Then I see text "DB Results is a digital business consulting and technology company. We provide strategy, consulting, digital, technology and operations services that help your business move from strategy to reality." displayed
   # Then I hover over "Who We Are" and click on "About Us"
     Then I click on button "search-cse-button"
     And I enter the details as
      | Fields              | Value         |
      | search-text    | TEST          |
    And I hit Enter
    Then I wait for "3000" millisecond
    Then I check I am on "SearchResults" page
    Then I see text "Pulse+IT - eHealth solution on the horizon to help cure hepatitis C" displayed
   		
    Examples: 
      | PortalName |
      | DBTEST     |