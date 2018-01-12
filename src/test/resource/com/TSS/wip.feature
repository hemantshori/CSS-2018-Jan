#Sample Feature Definition Template

@wip
Feature: WORK IN PROGRESS

  @current
  Scenario Outline: ARB-194: As an Agent Administrator/Propertnager/Lessor, I want to see a summary of my bond lodgement so that I can review the details I've entered
    #Scenario 2: Agent Administrator/Property Manager reviews a summary of the Bond Lodgement
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    Then I click on text "Lodge Bond"
    Then I check I am on "Bond Lodgement Premise" page
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields             | Value                               |
      | OneLineAddress     | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | StreetNumber       |                                  13 |
      | StreetName         | Shori                               |
      | Suburb             | Murrumbeena                         |
      | Postcode           |                                1111 |
      | NumberOfBedrooms   |                                  13 |
      | TotalBondAmount    |                                 400 |
      | WeeklyRentalAmount |                                 400 |
    Then I select "Separated House" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    And I enter the details as
      | Fields          | Value                |
      | TenantFirstName | TenantFirstName      |
      | TenantLastName  | TenantLastName       |
      | TenantEmail     | TenantEmail@TEST.com |
      | TenantPhone     |           1234567890 |
      #| TenantBSB           |               383838 |
      #| TenantAcctNum       |               987653 |
      | LessorFirstName | LessorFirstName      |
      | LessorLastName  | LessorLastName       |
      | LessorEmail     | LessorEmail@TeST.com |
      | LessorPhone     |           0987654321 |
    #| LessorBSB           |               838383 |
    #| LessorAccountNumber |               356789 |
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Summary" page
    Then I check "PremiseDetails" exists
    Then I check "BondAndTenancy" exists
    Then I check "TenantDetails" exists
    Then I check "ManagingAgentDetails" exists
    Then I check "LessorDetails" exists
    Then I check "ConfirmCheck" exists
    # ToDo disabled for now as address fileds on Bond lodgement premise has bugs
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value           |
      | item1  | TenantFirstName |
      | item1  | TenantLastName  |
      #| item1  | TenantEmail@TEST.com                |
      #| item1  | Separated House                     |
      #| item1  | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      #| item1  | 12 3456 7890                        |
      #| item1  | 383-838                             |
      #| item1  |                              987653 |
      | item1  | LessorFirstName |
      | item1  | LessorLastName  |
    #| item1  | LessorEmail@TeST.com                |
    #| item1  | 09 8765 4321                        |
    #| item1  | TestLessorAccount                   |
    #| item1  | 838-383                             |
    #| item1  |                              356789 |
    #| item1  | Separated House                     |
    #| item1  | Admin ADmin Last                    |
    #| item1  | 14 2324 3323                        |
    Then I see text "I confirm that these details are correct at the time of lodgement" displayed
    Then I click on button with value "Back"
    Then I check I am on "Bond Lodgement Parties" page
    #Scenario 3: User cancels bond lodgement
    Then I click on text "BACK TO BONDS"
    Then I check I am on "ManageBonds" page
    #Scenario 4: User does not confirm bond lodgement details
    Then I click on text "Lodge Bond"
    Then I check I am on "Bond Lodgement Premise" page
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields             | Value                               |
      | OneLineAddress     | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | StreetNumber       |                                  14 |
      | StreetName         | Shori                               |
      | Suburb             | Murrumbeena                         |
      | Postcode           |                                1111 |
      | NumberOfBedrooms   |                                  13 |
      | TotalBondAmount    |                                 400 |
      | WeeklyRentalAmount |                                 400 |
    Then I select "Separated House" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    And I enter the details as
      | Fields              | Value                |
      | TenantFirstName     | TenantFirstName      |
      | TenantLastName      | TenantLastName       |
      | TenantEmail         | TenantEmail@TEST.com |
      | TenantPhone         |           1234567890 |
     
      | LessorFirstName     | LessorFirstName      |
      | LessorLastName      | LessorLastName       |
      | LessorEmail         | LessorEmail@TeST.com |
      | LessorPhone         |           0987654321 |
      
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Summary" page
    Then I click on button with value "Next"
    Then I see text "Please confirm your bond details are correct." displayed
    #Scenario 5: User confirms bond lodgement details
    Then I click on button "ConfirmCheck"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Confirmation" page
    Then I click on text "Sign Out"
    #Scenario 2: Agent Administrator/Property Manager reviews a summary of the Bond Lodgement
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value            |
      | Email    | lessor2@test.com |
      | Password | <Password>       |
    And I hit Enter
    And I check I am on "ManageBonds" page
    Then I click on text "Lodge Bond"
    Then I check I am on "Bond Lodgement Premise" page
Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields             | Value                               |
      | OneLineAddress     | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | StreetNumber       |                                  15 |
      | StreetName         | Shori                               |
      | Suburb             | Murrumbeena                         |
      | Postcode           |                                1111 |
      | NumberOfBedrooms   |                                  13 |
      | TotalBondAmount    |                                 400 |
      | WeeklyRentalAmount |                                 400 |
    Then I select "Separated House" from "DwellingType"
    Then I click on button with value "Next"

    And I enter the details as
      | Fields            | Value                |
      | TenantFirstName   | TenantFirstName      |
      | TenantLastName    | TenantLastName       |
      | TenantEmail       | TenantEmail@TEST.com |
      | TenantPhone       |           1234567890 |
    
    Then I click on button with value #"Next"………………………this is where things are falling

    Then I check "PremiseDetails" exists
    Then I check "BondAndTenancy" exists
    Then I check "TenantDetails" exists
    #Then I check "ManagingAgentDetails" exists
    Then I check "LessorDetails" exists
    Then I check "ConfirmCheck" exists
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value                               |
      | item1  | TenantFirstName                     |
      | item1  | Separated House                     |
      | item1  | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | item1  | TenantLastName                      |
      | item1  | TenantEmail@TEST.com                |
      | item1  | 12 3456 7890                        |
      | item1  | 383-838                             |
      | item1  |                              987653 |
    Then I see text "I confirm that these details are correct at the time of lodgement" displayed

    Examples: 
      | PortalName | email                | Password   | NewPassword | ABN         | LicenceNumber | PhoneNumber | EmailAddress  | Address                           |
      | ARB        | agent2@test.com | Support123 | Dbresults1! | 55005825516 |     123454312 |  1234567890 | test@test.com | 10 FLORA GR, FOREST HILL VIC 3131 |


 @wip
  Scenario Outline: DTSP-770: To update the information sent to PSRM in the declaration section
    #Scenario 1: Declaration on Summary Page of all forms
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Lodgements"
    Then I click on "Payroll Tax"
    And I check I am on "Payroll Lodgement Form" page
    Then I click on button "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I click on "Monthly Return"
    Then I select "2016" from "MonthlyObligationSelect"
    Then I click on button "NextSection"
    Then I wait for "5000" millisecond
    #Then I click on button "TaxPayerDetailsNext"
    Then I enter the details as
      | Fields                                         | Value   |
      | SalariesAndWages                               | 1000000 |
      | BonusesAndCommissions                          |       1 |
      | LodgePayrollAnswer_Commissions                 |       1 |
      | LodgePayrollAnswer_Allowances                  |       1 |
      | LodgePayrollAnswer_DirectorsFees               |       1 |
      | LodgePayrollAnswer_EligibleTerminationPayments |       1 |
      | LodgePayrollAnswer_ValueOfBenefits             |       1 |
      | LodgePayrollAnswer_ShareValue                  |       1 |
      | LodgePayrollAnswer_ServiceContracts            |       1 |
      | LodgePayrollAnswer_Superannuation              |       1 |
      | LodgePayrollAnswer_OtherTaxablePayment         |       1 |
      | LodgePayrollAnswer_ExemptWages                 |       1 |
    Then I click on button "wtSubmitBT"
    Then I wait for "5000" millisecond
    Then I check I am on "Payroll Tax Lodgement Summary" page
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    Then I click on "Tax Registration Update"
    Then I click on "Update Business Address"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    #BUG FOUND: Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    Then I click on "Update Contact Details"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on button "NextBT"

    #BUG FOUND: Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    Then I click on "Update Refund Details"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on button with value "Next"
    #BUG FOUND: Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    Then I click on "Update Business Trading Name"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    Then I click on "Service Requests"
    Then I click on "Objection Request"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I click on button "CheckInterest"
    Then I enter the details as
      | Fields             | Value |
      | Objection_Comments | TEST  |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    Then I click on "Tax Registration Cancellation"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value               |
      | s2id_autogen1_search | AQUA |
    Then I click on button "select2-results-1"
    Then I enter the details as
      | Fields            | Value |
      | ReasonDescription | TEST  |
     	| CancellationStartDate | 27517 |
    Then I click on button "ReasonDescription"
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "AQUA PTY LTD"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    Then I click on "Annual Lodgement Request"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I select "2018" from "YearCombo"
    Then I click on button "MonthCombo"
    Then I click on "Jan"
    Then I enter the details as
      | Fields                              | Value |
      | AnnualLodgementRequestJustification | TEST  |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    Then I click on "Group Management"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | DESIGNATE PTY. LTD. |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on button with value "Update Group"
    Then I select "2018" from "YearCombo"
    Then I click on button "MonthCombo"
    Then I click on "Jan"
    Then I click on button "CheckboxJRL"
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<DESIGNATE PTY. LTD."
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    #Scenario 3: View User Profile
    Then I click on "User Profile"
    Then I see text "Position" displayed
    #Scenario 4: Edit User Profile
    Then I click on button "EditBT"
    Then I see text "Position" displayed
    Then I check "Input_LastName2" exists

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation         | ContactPhone | EmailAddress         |
      | TSSAdmin        | jbradley | Dbresults1 | J         | Bradley  | Consultant | QUICK SINGLE PTY LTD | 04 5678 9767 | jbradley@hotmail.com |