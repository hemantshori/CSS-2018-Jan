Feature: Regression for TSS

  ###########################################################################################################
  #################################### PHASE 1 ITERATION 1 ################################################
  ###########################################################################################################
  #alt username: hemant.shori
  #alt password: USBcoffee1
  Scenario Outline: DTSP-55 : As a DB Portal Administrator I want to edit a message's description so that I can customise the description for an organisation
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Given I want to login to portal "MessageEdit"
    Then I see text "<DescriptionBefore>" displayed
    Then I see text "<DescriptionAfter>" not displayed
    Then I click on object with xpath "//td//span[contains(text(), '<DescriptionBefore>')]/../..//td//a"
    #Scenario 1: Administrator accesses the edit function
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName          |
      | text1 | Feedback Msg Code |
      | text2 | Description       |
    Then I check "SaveButton" exists
    Then I check "CancelButton" exists
    And I enter the details as
      | Fields                      | Value              |
      | FeedbackMsgText_Description | <DescriptionAfter> |
    Then I click on button with value "Save"
    Then I see text "<DescriptionAfter>" displayed
    Then I see text "<DescriptionBefore>" not displayed
    Then I click on object with xpath "//td//span[contains(text(), '<DescriptionAfter>')]/../..//td//a"
    And I enter the details as
      | Fields                      | Value               |
      | FeedbackMsgText_Description | <DescriptionBefore> |
    Then I click on button with value "Save"
    Then I see text "<DescriptionBefore>" displayed
    Then I see text "<DescriptionAfter>" not displayed
    Then I click on object with xpath "//td//span[contains(text(), '<DescriptionBefore>')]/../..//td//a"
    Then I click on button with value "Cancel"
    #Scenario 2: Administrator cancels edit function with no unsaved changes
    Then I check I am on "Feedback Msg Texts" page
    Then I see text "<DescriptionBefore>" displayed
    Then I see text "<DescriptionAfter>" not displayed

    Examples: 
      | PortalName | UserNameField | PasswordField | UserName | Password   | DropDownName    | DropDownOption  | DescriptionBefore                | DescriptionAfter |
      | TSSAdmin   | UserNameInput | PasswordInput | TSSAdmin | Dbresults1 | FeedbackMsgText | Username Exists | Invalid ABN and CRN combination. | TEST TEST TEST   |

  @updated
  Scenario Outline: DTSP-56 :As a DB Portal Administrator I want to add a new message so that required messages are displayed in the portal
    #DTSP-57 :As a DB Portal Administrator I want to delete a message so that I can remove messages no longer required
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Given I want to login to portal "MessageEdit"
    Then I see text "<NewMessage>" not displayed
    Then I click on button with value "Add New"
    Then I click on button "CancelButton"
    #Scenario 2: Administrator cancels edit function with no unsaved changes
    Then I check I am on "Feedback Msg Texts" page
    #Scenario 1: Administrator accesses the edit function
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName          |
      | text1 | Feedback Msg Code |
      | text2 | Description       |
    Then I click on button "AddNewButton"
    Then I check "SaveButton" exists
    Then I check "CancelButton" exists
    And I enter the details as
      | Fields                      | Value        |
      | FeedbackMsgText_Description | <NewMessage> |
    Then I select "Invalid ABN" from "FeedbackMsgText_FeedbackMsgCode"
    Then I click on button with value "Save"
    Then I see text "<NewMessage>" displayed
    Then I click on object with xpath "//td//span[contains(text(), '<NewMessage>')]/../following-sibling::td//a"
    Then I see "Are you sure you want to delete?" displayed on popup and I click "Cancel"
    Then I click on object with xpath "//td//span[contains(text(), '<NewMessage>')]/../following-sibling::td//a"
    Then I see "Are you sure you want to delete?" displayed on popup and I click "OK"
    Then I see text "<NewMessage>" not displayed

    Examples: 
      | PortalName | UserNameField | PasswordField | UserName | Password   | DropDownName    | DropDownOption  | NewMessage              |
      | TSSAdmin   | UserNameInput | PasswordInput | TSSAdmin | Dbresults1 | FeedbackMsgText | Username Exists | This is a test message! |

  @done
  Scenario Outline: DTSP-233: As a DB Portal Administrator, I want to be able to search/add/edit/remove the tool tips displayed on forms so that I can help the end user better understand the form field/s
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Given I want to login to portal "PageTexts"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName  |
      | item2 | Text Code |
      | item4 | Is Active |
    Then I see text "Description" displayed
    # check for search
    And I enter the details as
      | Fields      | Value    |
      | SearchInput | Password |
    Then I click on button "PageTextSerchBt"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                  |
      | item2 | ResetPasswordLine1        |
      | item2 | HintToolTip               |
      | item2 | PasswordValidation        |
      | item2 | ForgotPasswordEmailLine3  |
      | item2 | ResetPasswordExpiredLine1 |
      | item2 | ResetPasswordInvalidLine2 |
      | item2 | ForgotPasswordEmailLine2  |
      | item2 | ForgotPasswordEmailLine1  |
      | item2 | LockedAccountLine2        |
    And I enter the details as
      | Fields      | Value |
      | SearchInput |       |
    Then I see text "<NewDescription>" not displayed
    #check for editing
    #add tips
    Then I click on button "AddNewButton"
    And I enter the details as
      | Fields               | Value            |
      | PageText_Description | <NewDescription> |
    Then I select "EmailSignature" from "PageText_TextCode"
    Then I click on button with value "Save"
    Then I wait for "5000" millisecond
    And I enter the details as
      | Fields      | Value |
      | SearchInput | a     |
    Then I click on button "PageTextSerchBt"
    #Edit
    Then I see text "<NewDescription>" displayed
    Then I click on object with xpath "//td[contains(text(), '<NewDescription>')]/..//a"
    And I enter the details as
      | Fields               | Value             |
      | PageText_Description | <NewDescription2> |
    Then I click on button with value "Save"
    Then I see text "<NewDescription>" not displayed
    Then I see text "<NewDescription2>" displayed
    #Delete
    Then I click on object with xpath "//td[contains(text(), '<NewDescription2>')]/..//a[contains(@id, 'PageTextDeleteLink')]"
    Given I want to login to portal "PageTexts"
    Then I see text "<NewDescription>" not displayed
    Then I see text "<NewDescription2>" not displayed

    Examples: 
      | PortalName | UserNameField | PasswordField | UserName | Password   | NewDescription  | NewDescription2     |
      | TSSAdmin   | UserNameInput | PasswordInput | TSSAdmin | Dbresults1 | This is a test! | This is a test two! |


  Scenario Outline: DTSP-358: As an end user, I want to be able to submit my Annual Payroll Tax Return Form
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I check I am on "Tooltips" page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName   |
      | item9 | Lodgements |
    And I click on "Return Lodgements"
    And I click on "Payroll Tax"
    And I check I am on "Payroll Lodgement Form" page
    Then I click on button with value "Cancel"
    Then I check I am on "Home" page
    And I click on "Return Lodgements"
    And I click on "Payroll Tax"
    And I check I am on "Payroll Lodgement Form" page
    Then I click on button with value "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I click on button "LodgePayrollAnswer_TypeMonthly"
    Then I select "2017" from "MonthlyObligationSelect"
    Then I click on button "NextSection"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields                                         | Value  |
      | SalariesAndWages                               | 100000 |
      | BonusesAndCommissions                          | 100000 |
      | LodgePayrollAnswer_Commissions                 | 100000 |
      | LodgePayrollAnswer_Allowances                  | 100000 |
      | LodgePayrollAnswer_DirectorsFees               | 100000 |
      | LodgePayrollAnswer_EligibleTerminationPayments | 100000 |
      | LodgePayrollAnswer_ValueOfBenefits             | 100000 |
      | LodgePayrollAnswer_ShareValue                  | 100000 |
      | LodgePayrollAnswer_ServiceContracts            | 100000 |
      | LodgePayrollAnswer_Superannuation              | 100000 |
      | LodgePayrollAnswer_OtherTaxablePayment         | 100000 |
      | LodgePayrollAnswer_ExemptWages                 | 100000 |
    Then I click on button "Submit"
    Then I check I am on "Payroll Tax Lodgement Summary" page
    #Check for Taxpayer Details
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                         |
      | item9 | Organisation Name                |
      | item9 | Australian Business Number (ABN) |
      | item9 | Client Reference Number (CRN)    |
    #Check for Return Type
    Then "<Item>" is displayed as "<ItemName>"
      | Item | ItemName                   |
      | item | Return Type                |
      | item | Monthly Payroll Tax Return |
      | item | Return Period              |
    #Check for Declaration
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    #disables as the displyed name is not in capitals, existing bug.
    #Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    Then I click on button "CorrectInfoDeclared"
    Then I check "SummarySubmit" is not readonly
    Then I click on button with value "Back"
    Then I check I am on "Payroll Lodgement Form" page

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation                           | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | COMPANY Y                              | 04 5678 9767 | katherine.santos@dbresults.com.au |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | Bye Debts Pty Ltd | 04 5678 9767 | katherine.santos@dbresults.com.au |

  ###########################################################################################################
  #################################### PHASE 1 ITERATION 2 ################################################
  ###########################################################################################################
  # Before running this script, go to https://test-ssc.dbresults.com.au/TSSAccountMgmt/DataExtensions.aspx
  # Find jbradley's account and make sure he has an CRN, an ABN and his employer status is set to 'Designated group employer for a group and lodging for itself'
  # As of 12 pm 9/1/2017 these settings have already been implemented, but double-checking them is advised.
  
  Scenario Outline: DTSP-356 Error handling for Annual Payroll Tax Reconciliation when fields returned from back end system are known error field mapping
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I check I am on "Tooltips" page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName   |
      | item9 | Lodgements |
    And I click on "Return Lodgements"
    And I click on "Payroll Tax"
    And I check I am on "Payroll Lodgement Form" page
    Then I click on button with value "Cancel"
    Then I check I am on "Home" page
    And I click on "Return Lodgements"
    And I click on "Payroll Tax"
    And I check I am on "Payroll Lodgement Form" page
    Then I click on button with value "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | Designate |
    Then I click on button "select2-results-1"
    Then I click on button "LodgePayrollAnswer_TypeAnnual"
    Then I select "01 Jul 2015 - 30 Jun 2016" from "AnnualObligationSelect"
    Then I click on button "NextSection"
    Then I click on button "ClaimingACTProportion_Yes"
    #Scenario 2: Aus wide wages is not greater than ACT Taxable wages
    Then I enter the details as
      | Fields                                         | Value  |
      | SalariesAndWages                               | 100000 |
      | BonusesAndCommissions                          | 100000 |
      | LodgePayrollAnswer_Commissions                 | 100000 |
      | LodgePayrollAnswer_Allowances                  | 100000 |
      | LodgePayrollAnswer_DirectorsFees               | 100000 |
      | LodgePayrollAnswer_EligibleTerminationPayments | 100000 |
      | LodgePayrollAnswer_ValueOfBenefits             | 100000 |
      | LodgePayrollAnswer_ShareValue                  | 100000 |
      | LodgePayrollAnswer_ServiceContracts            | 100000 |
      | LodgePayrollAnswer_Superannuation              | 100000 |
      | LodgePayrollAnswer_OtherTaxablePayment         | 100000 |
      | LodgePayrollAnswer_ExemptWages                 | 100000 |
      | LodgePayrollAnswer_AustralianWide              |     99 |
      | LodgePayrollAnswer_DaysPaidTaxable             |      1 |
      | LodgePayrollAnswer_GroupActWages               |    100 |
    Then I click on button "Submit"
    #TODO LATER:
    #Scenario 3: Group ACT wages is not greater than ACT Taxable wages
    Then I see text "Group ACT wages must be equal to or greater than ACT taxable wages" displayed
    #Scenario 4: Aus wide wages is not greater than Group ACT wages
    Then I see text "Australia-wide Group Wages incl. ACT should be greater than or equal to the Group ACT Wages." shown

    Examples: 
      | PortalName | UserNameField | PasswordField | UserName | Password   | CRN         | ABN         |
      | TSSAdmin   | UserNameInput | PasswordInput | jbradley | Dbresults1 | 12345678901 | 12345678901 |

  #NOTE: Ensure that jbradley has a current employee type selected in the data extensions page
  Scenario Outline: DTSP-311: Validation Rules and Errors to be used across Annual Reconciliation Form
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I check I am on "Tooltips" page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName   |
      | item9 | Lodgements |
    And I click on "Return Lodgements"
    And I click on "Payroll Tax"
    And I check I am on "Payroll Lodgement Form" page
    Then I click on button with value "Cancel"
    Then I check I am on "Home" page
    And I click on "Return Lodgements"
    And I click on "Payroll Tax"
    And I check I am on "Payroll Lodgement Form" page
    Then I click on button with value "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    Then I click on button "LodgePayrollAnswer_TypeAnnual"
    Then I select "2015" from "AnnualObligationSelect"
    Then I click on button "NextSection"
    Then I click on button "ClaimingACTProportion_Yes"
    #scenario 1: Restricted fields contain incorrect text type
    Then I enter the details as
      | Fields                                         | Value |
      | SalariesAndWages                               | ABC   |
      | BonusesAndCommissions                          | ABC   |
      | LodgePayrollAnswer_Commissions                 | ABC   |
      | LodgePayrollAnswer_Allowances                  | ABC   |
      | LodgePayrollAnswer_DirectorsFees               | ABC   |
      | LodgePayrollAnswer_EligibleTerminationPayments | ABC   |
      | LodgePayrollAnswer_ValueOfBenefits             | ABC   |
      | LodgePayrollAnswer_ShareValue                  | ABC   |
      | LodgePayrollAnswer_ServiceContracts            | ABC   |
      | LodgePayrollAnswer_Superannuation              | ABC   |
      | LodgePayrollAnswer_OtherTaxablePayment         | ABC   |
      | LodgePayrollAnswer_ExemptWages                 | ABC   |
      | LodgePayrollAnswer_AustralianWide              | ABC   |
      | LodgePayrollAnswer_DaysPaidTaxable             | ABC   |
    # | LodgePayrollAnswer_GroupActWages| ABC   |
    Then I check "SalariesAndWages" is empty
    Then I check "BonusesAndCommissions" is empty
    Then I check "LodgePayrollAnswer_Commissions" is empty
    Then I check "LodgePayrollAnswer_Allowances" is empty
    Then I check "LodgePayrollAnswer_DirectorsFees" is empty
    Then I check "LodgePayrollAnswer_EligibleTerminationPayments" is empty
    Then I check "LodgePayrollAnswer_ValueOfBenefits" is empty
    Then I check "LodgePayrollAnswer_ShareValue" is empty
    Then I check "LodgePayrollAnswer_ServiceContracts" is empty
    Then I check "LodgePayrollAnswer_Superannuation" is empty
    Then I check "LodgePayrollAnswer_OtherTaxablePayment" is empty
    Then I check "LodgePayrollAnswer_ExemptWages" is empty
    Then I check "LodgePayrollAnswer_AustralianWide" is empty
    Then I check "LodgePayrollAnswer_DaysPaidTaxable" is empty
    #Then I check "LodgePayrollAnswer_GroupActWages" is empty
    #scenario 5: Mandatory fields not filled in
    Then I check "Submit" is readonly
    #scenario 2:  Restricted fields contain correct text type
    Then I enter the details as
      | Fields                                         | Value   |
      | SalariesAndWages                               |  100000 |
      | BonusesAndCommissions                          |  100000 |
      | LodgePayrollAnswer_Commissions                 |  100000 |
      | LodgePayrollAnswer_Allowances                  |  100000 |
      | LodgePayrollAnswer_DirectorsFees               |  100000 |
      | LodgePayrollAnswer_EligibleTerminationPayments |  100000 |
      | LodgePayrollAnswer_ValueOfBenefits             |  100000 |
      | LodgePayrollAnswer_ShareValue                  |  100000 |
      | LodgePayrollAnswer_ServiceContracts            |  100000 |
      | LodgePayrollAnswer_Superannuation              |  100000 |
      | LodgePayrollAnswer_OtherTaxablePayment         |  100000 |
      | LodgePayrollAnswer_ExemptWages                 |  100000 |
      | LodgePayrollAnswer_AustralianWide              | 5000000 |
      | LodgePayrollAnswer_DaysPaidTaxable             |     999 |
      | GroupActWages                                  | 5000000 |
    Then I check "SalariesAndWages" contains "$ 100,000"
    Then I check "BonusesAndCommissions" contains "$ 100,000"
    Then I check "LodgePayrollAnswer_Commissions" contains "$ 100,000"
    Then I check "LodgePayrollAnswer_Allowances" contains "$ 100,000"
    Then I check "LodgePayrollAnswer_DirectorsFees" contains "$ 100,000"
    Then I check "LodgePayrollAnswer_EligibleTerminationPayments" contains "$ 100,000"
    Then I check "LodgePayrollAnswer_ValueOfBenefits" contains "$ 100,000"
    Then I check "LodgePayrollAnswer_ShareValue" contains "$ 100,000"
    Then I check "LodgePayrollAnswer_ServiceContracts" contains "$ 100,000"
    Then I check "LodgePayrollAnswer_Superannuation" contains "$ 100,000"
    Then I check "LodgePayrollAnswer_OtherTaxablePayment" contains "$ 100,000"
    Then I check "LodgePayrollAnswer_ExemptWages" contains "$ 100,000"
    Then I check "LodgePayrollAnswer_AustralianWide" contains "$ 5,000,000"
    Then I check "LodgePayrollAnswer_DaysPaidTaxable" contains "999"
    #Then I check "LodgePayrollAnswer_GroupActWages" contains "$ 1,500,000"
    #Scenario 7: Number of days is invalid
    Then I click on button "SubmitBT"
    Then I see text "Days where 1 group member paid or was liable to pay taxable or interstate should be less than or equal to the number of days in that particular filing period." displayed
    #Scenario 6: Mandatory fields all filled in
    Then I enter the details as
      | Fields                             | Value |
      | LodgePayrollAnswer_DaysPaidTaxable |     1 |
    Then I click on button "Submit"
    Then I wait for "5000" millisecond

    #Then I check I am on "Payroll Tax Lodgement Summary" page
    Examples: 
      | PortalName | UserNameField | PasswordField | UserName | Password   | CRN         | ABN         |
      | TSSAdmin   | UserNameInput | PasswordInput | jbradley | Dbresults1 | 98765123456 | 12345678902 |

  Scenario Outline: DTSP-401: As an end user, I should not be able to view/select the 'Return Type' section on the Payroll Tax Lodgement forms when I am on subsequent sections after clicking 'Next'
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I click on "Return Lodgements"
    And I click on "Payroll Tax"
    And I check I am on "Payroll Lodgement Form" page
    Then I click on button with value "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <BusinessName> |
    Then I click on button "select2-results-1"
    Then I click on button "LodgePayrollAnswer_TypeAnnual2"
    Then I wait for "5000" millisecond
    Then I click on button "LodgePayrollAnswer_TypeMonthly"
    #Then I click on "2017"
    Then I select "2016" from "MonthlyObligationSelect"
    Then I click on button "NextSection"
    Then I click on button with value "Back"
    Then I check "MonthlyObligationSelect" is readonly

    Examples: 
      | PortalName | UserName | Password   | BusinessName |
      | TSSAdmin   | jbradley | Dbresults1 | QUICK SINGLE |

  ###########################################################################################################
  #################################### PHASE 1 ITERATION 3 ################################################
  ###########################################################################################################
  Scenario Outline: DTSP-318: As a Customer Portal Administrator (CPA), I want to be able to search for taxpayer tips on Manage Tips page so that I can find the tips I need
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Given I want to login to portal "TSS_Tooltips"
    # Scenario 1: CPA access the 'Manage Tips' page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName             |
      | item2 | Page                 |
      | item3 | Section              |
      | item5 | Tooltips Description |
      | item5 | Identifier           |
      | item5 | Status               |
    And I enter the details as
      | Fields      | Value      |
      | SearchInput | PayrollTax |
    Then I click on button "SearchBT"
    #Scenario 2: CPA searches for the taxpayer tips on the 'Manage Tips' page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                               |
      | item2 | PayrollTax_DeclarationConfirm          |
      | item3 | PayrollTax_ClaimingACT                 |
      | item5 | PayrollTax_CRN                         |
      | item5 | PayrollTax_EligibleTerminationPayments |
      | item5 | PayrollTax_ClientNumber                |
    Then I click on button "ResetBT"
    #Scenario 3: CPA filters tips on the 'Manage Tips' page
    Then I click on button "FilterByDescription"
    And I enter the details as
      | Fields      | Value |
      | SearchInput | Wages |
    Then I hit Enter
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                                           |
      | item2 | PayrollTax_TaxableWages_DaysPaidTaxableOrInterstat |
      | item3 | PayrollTax_ExemptWages                             |
      | item5 | PayrollTax_TaxableWages                            |
      | item5 | PayrollTax_TaxableWages_ACTWagesPaidorPayable      |
      | item5 | ACT Wages Paid or Payable                          |
    #Scenario 4: More than 10 search results
    Given I want to login to portal "TSS_Tooltips"
    And I enter the details as
      | Fields      | Value      |
      | SearchInput | PayrollTax |
    Then I click on button "SearchBT"
    Then I see "Counter" displayed
    And I enter the details as
      | Fields      | Value   |
      | SearchInput | Account |
    Then I see "Counter" displayed

    Examples: 
      | PortalName | UserNameField | PasswordField | UserName | Password   |
      | TSSAdmin   | UserNameInput | PasswordInput | TSSAdmin | Dbresults1 |

  @current
  Scenario Outline: DTSP-145
    Given I want to login to portal "<PortalName>"
    Then I check "UserNameEmailLabel" has CSS property "content" with value ""*""
    Then I check "PasswordLabel" has CSS property "content" with value ""*""
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Given I want to login to portal "AccountManagement"
    Then I check I am on "View User Profile" page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName      |
      | item3 | First Name    |
      | item5 | Last Name     |
      | item5 | Email Address |
      | item5 | Phone Number  |
      | item5 | Position      |
      | item5 | Password      |
      | item5 | Hint          |
    Then I check "Title_wtView_Profile" exists
    Then I check "Title_wtView_Contact" exists
    Then I check "Title_wtView_Security" exists

    Examples: 
      | PortalName | UserNameField | PasswordField | UserName | Password   | CRN         | ABN         |
      | TSSAdmin   | UserNameInput | PasswordInput | jbradley | Dbresults1 | 12121212121 | 21212121212 |

  Scenario Outline: DTSP-147
    Given I want to login to portal "<PortalName>"
    Then I check "UserNameEmailLabel" has CSS property "content" with value ""*""
    Then I check "PasswordLabel" has CSS property "content" with value ""*""
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Given I want to login to portal "AccountManagement"
    Then I click on button "EditBT"
    #Scenario 1: User accesses the edit function
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName      |
      #| item2 | Username      |
      | item3 | First Name    |
      | item5 | Last Name     |
      | item5 | Email Address |
      | item5 | Phone Number  |
      | item5 | Position      |
      | item5 | Password      |
      | item5 | Hint          |
    Then I enter the details as
      | Fields            | Value |
      | Input_PhoneNumber | TEST  |
    Then I check "Input_PhoneNumber" is empty
    #Scenario 3: User has not entered all the mandatory fields
    Then I check "CancelBT" is readonly
    #Scenario 4, 6: Scenario 6: Profile settings details does not pass all validations
    Then I enter the details as
      | Fields                   | Value                 |
      | Input_FirstName          | TEST                  |
      | Input_LastName           | TEST                  |
      | Input_PhoneNumber        |                 33333 |
      | Input_Email              | TEST                  |
      | Input_NewPassword        | adsfasdfaf            |
      | Input_NewpasswordConfirm | asfsadfsadf           |
      | Input_Hint               | testsetsetwetstsetset |
    Then I wait for "5000" millisecond
    Then I click on button "Input_FirstName"
    Then I click on button "Submit"
    #Then I see text "Please enter a valid email address" displayed
    Then I see text "Incorrect Email Format." displayed
    Then I see text "Invalid Phone Number. Phone Number should be 10 digits. Please try again." displayed
    Then I see text "New Password and Confirm Password do not match. Please try again." displayed
    Then I see text "New Password is invalid. Please try again." displayed
    #Scenario 8: User cancels edit function with unsaved changes
    Then I click on button "Cancel"
    #Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "Cancel"
    And I "Accept" windows alert
 
    #Then I click on button "Cancel"
    ##Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Then I check I am on "View User Profile" page
    Given I want to login to portal "AccountManagement"
    #Then I click on button "Cancel"
    Then I check I am on "View User Profile" page
    #Scenario 5: Profile settings details pass all validations
    Then I click on button "EditBT"
    Then I enter the details as
      | Fields                   | Value                             |
      | Input_FirstName          | J                                 |
      | Input_LastName           | Bradley                           |
      | Input_PhoneNumber        |                        0456789767 |
      | Input_Email              | katherine.santos@dbresults.com.au |
      | Input_NewPassword        | Dbresults1                        |
      | Input_NewpasswordConfirm | Dbresults1                        |
      | Input_Hint               | DB RESULTS ONE                    |
    #Scenario 9: User update's Tax Agent Details (Tax Agent registered and activated on the Portal)
    Then I click on button "Input_FirstName"
    Then I click on button "Submit"
    Then I see text "Your changes have been successfully saved." displayed
    Then I check I am on "View User Profile" page

    Examples: 
      | PortalName | UserNameField | PasswordField | UserName | Password   | CRN         | ABN         |
      | TSSAdmin   | UserNameInput | PasswordInput | jbradley | Dbresults1 | 12121212121 | 21212121212 |

  #NOTE: Ensure that jbradley has a current employee type selected in the data extensions page
  Scenario Outline: DTSP-463: Display all the mandatory fields with an Asterisk (*)
    #On hold until a clear standard for the mandatory field asterisks can be made
    #PART 1: Login Screen
    Given I want to login to portal "<PortalName>"
    Then I check "UserNameEmailLabel" has CSS property "content" with value ""*""
    Then I check "PasswordLabel" has CSS property "content" with value ""*""
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I click on "Return Lodgements"
    And I click on "Payroll Tax"
    Then I click on button "Discard"
    #Part 2: Payroll Tax (Annual)
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value               |
      | s2id_autogen1_search | DESIGNATE PTY. LTD. |
    Then I click on button "select2-results-1"
    Then I click on "Annual Reconciliation"
    Then I select "2015" from "AnnualObligationSelect"
    Then I click on button "NextSection"
    Then I click on button "LodgePayrollAnswer_ClaimingACTProportion_Yes"
    Then I check "ClaimingACTProportion_Label" has CSS property "content" with value ""*""
    Then I click on button "ClaimingACTProportion_Yes"
    Then I check "AusWideWages" has CSS property "content" with value ""*""
    Then I check "GroupActWages" has CSS property "content" with value ""*""
    Then I click on "Sign Out"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    #PART 4: Tax Registration Form
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Payroll Tax Registration"
    Then I wait for "5000" millisecond
    Then I check "Label_AustralianBusinessNumber_ABN" has CSS property "content" with value ""*""
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I select "Company" from "SelectBusinessTypeCode"
    Then I wait for "5000" millisecond
    Then I check "Label_SelectBusinessType" has CSS property "content" with value ""*""
    Then I check "Label_EmployerName" has CSS property "content" with value ""*""
    Then I check "Label_BusinessTradingName" has CSS property "content" with value ""*""
    Then I check "Label_AustralianCompanyName_ACN" has CSS property "content" with value ""*""
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I click on button "RegistrationAnswer_ACN"
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    Then I check "Label_BusinessAdress_Country" has CSS property "content" with value ""*""
    Then I check "Label_BusinessAddress_AddressLine1" has CSS property "content" with value ""*""
    Then I check "Label_BusinessAdress_Suburb" has CSS property "content" with value ""*""
    Then I check "Label_BusinessAdress_Territory" has CSS property "content" with value ""*""
    Then I check "Label_BusinessAdress_Postcode" has CSS property "content" with value ""*""
    #Then I check "Text_PostalAddress" has CSS property "content" with value ""*""
    #Then I check "Text_AddresswhereBusinessRecordsarelocated_Jurisdi" has CSS property "content" with value ""*""
    Then I check "ContactPerson_FirstName" has CSS property "content" with value ""*""
    Then I check "ContactPerson_LastName" has CSS property "content" with value ""*""
    Then I check "Label_ContactPerson_ContactPhoneNumber" has CSS property "content" with value ""*""
    Then I check "Label_ContactPerson_EmailAddress" has CSS property "content" with value ""*""
    Then I enter the details as
      | Fields                    | Value         |
      | AddressLine1              | TEST          |
      | Address_City              | TEST          |
      | ContactPerson_FirstName   | TEST          |
      | ContactPerson_LastName    | TEST          |
      | ContactPerson_Email       | TEST@TEST.com |
      | PostCode                  |          3333 |
      | ContactPerson_PhoneNumber |    1234567890 |
    #Then I select "AL" from "Address_State"
    # Then I see text "Title" not displayed
    Then I click on button "OrgDetailsNextBt"
    Then I check "Label_BusinessActivityCategory" has CSS property "content" with value ""*""
    Then I wait for "5000" millisecond
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value        |
      | s2id_autogen1_search | Turf Growing |
    Then I click on button "select2-results-1"
    Then I click on button "ACTWagesPaidNext"
    Then I wait for "5000" millisecond
    Then I check "Label_DateBusinessCommencedEmployinginACT" has CSS property "content" with value ""*""
    Then I check "Label_DateBusinessBecameLiableintheACT" has CSS property "content" with value ""*""
    Then I check "Label_NumberofEmployeesinyourACTBusiness" has CSS property "content" with value ""*""
    #Then I see text "Are you a member of a group?*" displayed
    Then I check "Label_Asaneligibleemployer_doyouwishtoapplyforannu" has CSS property "content" with value ""*""
    #Then I check "Label_AnnualLodgementRequestJustification" has CSS property "content" with value ""*""
    #Then I check "Text_ContactPersonforPayrollTax" has CSS property "content" with value ""*""
    Then I enter the details as
      | Fields            | Value |
      | NumberOfEmployees |    33 |
    Then I click on button "DateBusinessStart"
    Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
    #	Then I enter the details as
    #  | DateBusinessStart  | 12032033 |
    Then I click on button "DateBusinessLiable"
    Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
    #Then I enter the details as
    # | DateBusinessLiable | 12032034 |
    Then I click on button "AnnualLodgementApproval_NO"
    Then I click on button "PayrollNext"
    Then I wait for "5000" millisecond
    Then I check "Label_BSB" has CSS property "content" with value ""*""
    Then I check "Label_BankAccountNumber" has CSS property "content" with value ""*""
    Then I check "Label_BankAccountName" has CSS property "content" with value ""*""
    Then I click on button "Refunds_NO"
    Then I click on button "RefundDetailsBT"
    Then I check "Label_Declarer_FirstName" has CSS property "content" with value ""*""
    Then I check "Label_Declarer_LastName" has CSS property "content" with value ""*""
    Then I check "Label_Declarer_Organisation" has CSS property "content" with value ""*""
    Then I check "Label_Declarer_Postion" has CSS property "content" with value ""*""
    Then I check "Label_Declarer_ContactPhoneNumber" has CSS property "content" with value ""*""
    Then I check "Label_Declarer_EmailAddress" has CSS property "content" with value ""*""

    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |

  @done
  Scenario Outline: DTSP-508: As an end user, I want to see a reminder message on the top of the Payroll Tax Registration form so I know I cannot save an incomplete form
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Payroll Tax Registration"
    Then I see text "Because you are not logged in, you cannot save an incomplete form for later. Please complete your form and submit it before closing your session" displayed

    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  ###########################################################################################################
  #################################### PHASE 1 ITERATION 4 ################################################
  ###########################################################################################################

  Scenario Outline: DTSP-523
    # Part of this story is automatically tested by others...
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | jbradley   |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return Lodgements"
    Then I click on "Payroll Tax"
    #PAYROLL TAX FORM TESTING WITH ANNUAL RECONCILIATION IS BLOCKED BY BUG DTSP-603
    Then I click on button "Discard"
    Then I check "NextSection" is readonly
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value        |
      | s2id_autogen1_search | QUICK SINGLE |
    Then I click on button "select2-results-1"
    Then I wait for "6000" millisecond
    Then I click on "Monthly Return"
    Then I select "2017" from "MonthlyObligationSelect"
    #Then I click on "May 2017"
    Then I wait for "6000" millisecond
    Then I click on button with value "Save and Next"
    Then I wait for "6000" millisecond
    Then I check "SubmitBT" is readonly
    Then I click on button "ClaimingACTProportion_Yes"
    Then I enter the details as
      | Fields                                         | Value |
      | SalariesAndWages                               | NO    |
      | BonusesAndCommissions                          | NO    |
      | LodgePayrollAnswer_Commissions                 | NO    |
      | LodgePayrollAnswer_Allowances                  | NO    |
      | LodgePayrollAnswer_DirectorsFees               | NO    |
      | LodgePayrollAnswer_EligibleTerminationPayments | NO    |
      | LodgePayrollAnswer_ValueOfBenefits             | NO    |
      | LodgePayrollAnswer_ShareValue                  | NO    |
      | LodgePayrollAnswer_ServiceContracts            | NO    |
      | LodgePayrollAnswer_Superannuation              | NO    |
      | LodgePayrollAnswer_OtherTaxablePayment         | NO    |
      | LodgePayrollAnswer_ExemptWages                 | NO    |
      | PayrollAnswer_AustralianWide                   | NO    |
    #| GroupActWages                                  | NO    |
    Then I check "SalariesAndWages" is readonly
    Then I check "BonusesAndCommissions" is readonly
    Then I check "LodgePayrollAnswer_Commissions" is readonly
    Then I check "LodgePayrollAnswer_Allowances" is readonly
    Then I check "LodgePayrollAnswer_DirectorsFees" is readonly
    Then I check "LodgePayrollAnswer_EligibleTerminationPayments" is readonly
    Then I check "LodgePayrollAnswer_ValueOfBenefits" is readonly
    Then I check "LodgePayrollAnswer_ShareValue" is readonly
    Then I check "LodgePayrollAnswer_ServiceContracts" is readonly
    Then I check "LodgePayrollAnswer_Superannuation" is readonly
    Then I check "LodgePayrollAnswer_OtherTaxablePayment" is readonly
    Then I check "LodgePayrollAnswer_ExemptWages" is readonly
    Then I check "LodgePayrollAnswer_AustralianWide" is readonly
    #Then I check "GroupActWages" is readonly
    Then I enter the details as
      | Fields                                         | Value |
      | SalariesAndWages                               |   100 |
      | BonusesAndCommissions                          |   100 |
      | LodgePayrollAnswer_Commissions                 |   100 |
      | LodgePayrollAnswer_Allowances                  |   100 |
      | LodgePayrollAnswer_DirectorsFees               |   100 |
      | LodgePayrollAnswer_EligibleTerminationPayments |   100 |
      | LodgePayrollAnswer_ValueOfBenefits             |   100 |
      | LodgePayrollAnswer_ShareValue                  |   100 |
      | LodgePayrollAnswer_ServiceContracts            |   100 |
      | LodgePayrollAnswer_Superannuation              |   100 |
      | LodgePayrollAnswer_OtherTaxablePayment         |   100 |
      | LodgePayrollAnswer_ExemptWages                 |   100 |
      #| GroupActWages                                  |     0 |
      | PayrollAnswer_AustralianWide                   |     0 |
    Then I click on button "SubmitBT"
    #Then I enter the details as
    #| Fields                 | Value |
    #| AnnualLessTotalTaxPaid | NO    |
    #Then I check "AnnualLessTotalTaxPaid" is readonly
    #Then I click on button "Discard"
    #Tax Registration Form
    Then I click on "Payroll Tax Registration"
    #Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    And I "Accept" windows alert
    Then I wait for "6000" millisecond
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "6000" millisecond
    Then I enter the details as
      | Fields                 | Value         |
      | EmployerName           | <CompanyName> |
      | BusinessTradingName    | <CompanyName> |
      | RegistrationAnswer_ACN | NO            |
    Then I select "Government" from "SelectBusinessTypeCode"
    #Then I check "RegistrationAnswer_ACN" is empty
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "6000" millisecond
    #Then I select "Direct Post" from "CommunicationMethodId"
    Then I enter the details as
      | Fields                    | Value         |
      | AddressLine1              | TEST          |
      | Address_City              | TEST          |
      | PostCode                  | NO            |
      | ContactPerson_FirstName   | TEST          |
      | ContactPerson_LastName    | TEST          |
      | ContactPerson_PhoneNumber | NO            |
      | ContactPerson_Email       | TEST@TEST.com |
    Then I check "PostCode" is readonly
    Then I check "ContactPerson_PhoneNumber" is readonly
    #Then I select "AL" from "Address_State"
    Then I enter the details as
      | Fields                    | Value      |
      | AddressLine1              | TEST       |
      | Address_City              | TEST       |
      | PostCode                  |       3333 |
      | ContactPerson_FirstName   | TEST       |
      | ContactPerson_LastName    | TEST       |
      | ContactPerson_PhoneNumber | 1234567890 |
    Then I click on button "AddressLine1"
    Then I click on button "OrgDetailsNext"
    Then I wait for "6000" millisecond
    Then I check "ACTWagesPaidNextBt" is readonly
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value        |
      | s2id_autogen1_search | Turf Growing |
    Then I click on button "select2-results-1"
    Then I click on button "ACTWagesPaidNextBt"
    Then I check "PayrollNext" is readonly
    Then I enter the details as
      | Fields                   | Value |
      | TaxableACTWages          | NO    |
      | wtAusWideTaxableWages    | NO    |
      | GroupAusWideTaxableWages | NO    |
      | NumberOfEmployees        | NO    |
    Then I check "TaxableACTWages" is readonly
    Then I check "wtAusWideTaxableWages" is readonly
    Then I check "GroupAusWideTaxableWages" is readonly
    Then I check "NumberOfEmployees" is readonly
    Then I enter the details as
      | Fields            | Value |
      | NumberOfEmployees |    33 |
    Then I click on button "DateBusinessStart"
    Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
    Then I click on button "DateBusinessLiable"
    Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
    #| DateBusinessStart  | 28517 |
    #| DateBusinessLiable | 28517 |
    #Then I click on "DateBusinessStart"
    #Then I click on "20170528"
    #Then I click on "DateBusinessLiable"
    #Then I click on "20170528"
    Then I click on button "PayrollNext"
    Then I enter the details as
      | Fields                 | Value |
      | RegistrationAnswer_BSB | NO    |
      | BankAccountNumber      | NO    |
      | BankAccountName        | NO    |
    Then I check "RegistrationAnswer_BSB" is readonly
    Then I check "BankAccountNumber" is readonly
    Then I check "BankAccountName" is readonly
    Then I check "RefundDetailsBT" is readonly
    Then I enter the details as
      | Fields                 | Value     |
      | RegistrationAnswer_BSB |    333333 |
      | BankAccountNumber      | 333333333 |
      | BankAccountName        | TEST      |
    Then I click on button "RefundDetailsBT"
    Then I enter the details as
      | Fields               | Value |
      | Declarer_PhoneNumber | NO    |
    Then I check "Declarer_PhoneNumber" is empty

    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |

  Scenario Outline: DTSP-537
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | jbradley   |
      | PasswordInput | <Password> |
    And I hit Enter
    #Scenario 1: Annual Rec [Single Emp Status]
    Then I click on "Return Lodgements"
    Then I click on "Payroll Tax"
    Then I click on button "GeneralDiscardBt"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search | QUICK |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on "Annual Reconciliation"
    Then I select "2016" from "AnnualObligationSelect"
    Then I click on button with value "Save and Next"
    Then I wait for "5000" millisecond
    Then I check object with xpath "//*[contains(@id, 'Titlewages')]//div[3]" contents match regex "\(\d{2} \w+ \d{4} - \d{2} \w+ \d{4} / [\w|\s|\W|\(|\)]+\)"
    Then I click on "Payroll Tax"
    Then I click on button with value "Discard"
    #Scenario 2: Annual Rec [Multi Emp Status]
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search | QUICK |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on "Annual Reconciliation"
    Then I select "2016" from "AnnualObligationSelect"
    Then I click on button "NextSection"
    Then I wait for "5000" millisecond
    Then I see text "Annual Reconciliation Return" displayed
    #Scenario 5: Days paid wage group Australia-wide" field removed from Payroll Tax
    Then I see text "Days paid wage group Australia-wide" not displayed
    Then I wait for "5000" millisecond
    Then I check object with xpath "//*[contains(@id, 'Titlewages')]//div[3]" contents match regex "\(\d{2} \w+ \d{4} - \d{2} \w+ \d{4} / [\w|\s|\W|\(|\)]+\)"
    #Scenario 3: Monthly Return
    Then I click on "Payroll Tax"
    Then I click on button with value "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search | QUICK |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I select "May 2017" from "MonthlyObligationSelect"
    Then I click on button "NextSection"
    Then I wait for "5000" millisecond
    #Scenario 4: Exempt wages question updated
    Then I see text "ACT wages not included on this return" displayed
    #Scenario 6: (Designated group employer for a group and lodging for itself’) Rename the field ‘Days where you paid or were liable to pay taxable or interstate wages’ to ‘Days where 1 group member paid or was liable to pay taxable or interstate wages’
    Then I click on "Payroll Tax"
    Then I click on button with value "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search | QUICK |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on "Annual Reconciliation"
    Then I select "2016" from "AnnualObligationSelect"
    Then I click on button "NextSection"
    Then I wait for "5000" millisecond
    Then I click on button "ClaimingACTProportion_Yes"
    Then I enter the details as
      | Fields                                         | Value   |
      | SalariesAndWages                               | 1000000 |
      | BonusesAndCommissions                          |     100 |
      | LodgePayrollAnswer_Commissions                 |     100 |
      | LodgePayrollAnswer_Allowances                  |     100 |
      | LodgePayrollAnswer_DirectorsFees               |     100 |
      | LodgePayrollAnswer_EligibleTerminationPayments |     100 |
      | LodgePayrollAnswer_ValueOfBenefits             |     100 |
      | LodgePayrollAnswer_ShareValue                  |     100 |
      | LodgePayrollAnswer_ServiceContracts            |     100 |
      | LodgePayrollAnswer_Superannuation              |     100 |
      | LodgePayrollAnswer_OtherTaxablePayment         |     100 |
      | LodgePayrollAnswer_ExemptWages                 |     100 |
    Then I see text "Days where you paid or were liable to pay taxable or interstate wages" displayed

    #Scenario 7:  (Designated group employer and lodging a joint return for itself and other ACT group members) Rename the field ‘Days where you paid or were liable to pay taxable or interstate wages’ to ‘Days where 1 group member paid or was liable to pay taxable or interstate wages’
    #Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    #Then I click on "Home"
    #Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    #Then I click on "Return Lodgements"
    #Then I click on "Payroll Tax"
    #Then I click on button with value "Discard"
    #Then I click on button "select2-chosen-1"
    #Then I enter the details as
    #| Fields               | Value     |
    #| s2id_autogen1_search | DESIGNATE |
    #Then I click on button "select2-results-1"
    #Then I wait for "5000" millisecond
    #Then I click on "Annual Reconciliation"
    #Then I select "2016" from "AnnualObligationSelect"
    #Then I click on button "NextSection"
    #Then I click on button "ClaimingACTProportion_Yes"
    #Then I see text "Days where 1 group member paid or was liable to pay taxable or interstate wages" displayed
    Examples: 
      | PortalName | UserNameField | PasswordField | Password   |
      | TSSAdmin   | UserNameInput | PasswordInput | Dbresults1 |

  @done
  Scenario Outline: DTSP-444: As an end user, I want to know my Payroll Tax Obligations (including Month and Year) which have not been lodged so I can lodge my monthly payroll tax accordingly
    #Scenario 5: Gather Obligation List [Monthly and Annual] [Exception Path]
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | jbradley   |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return Lodgements"
    Then I click on "Payroll Tax"
    Then I click on button "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search | AQUA  |
    Then I click on button "select2-results-1"
    Then I check "LodgePayrollAnswer_TypeMonthly" is readonly
    Then I see text "No Monthly Lodgements Available" displayed
    Then I check "LodgePayrollAnswer_TypeAnnual" is readonly
    Then I see text "No Annual Lodgements Available" displayed
    Then I check "NextSection" is readonly
    Then I click on button "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search | QUICK |
    Then I click on button "select2-results-1"
    Then I click on "Annual Reconciliation"
    Then I select "2014" from "AnnualObligationSelect"
    Then I click on button "NextSection"
    Then I see text "Annual Reconciliation Return" displayed
    Then I check object with xpath "//*[contains(@id, 'Titlewages')]//div[3]" contents match regex "\(\d{2} \w+ \d{4} - \d{2} \w+ \d{4} / [\w|\s|\W|\(|\)]+\)"
    #Then I see text "(01/07/2015 - 30/06/2016 / Designated group employer for a group and lodging for itself / 5)" displayed
    #Scenario 1: Gather Obligation List [Monthly] [Happy Path]
    Then I click on "Payroll Tax"
    #Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Then I click on button "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search | QUICK |
    Then I click on button "select2-results-1"
    Then I click on "Monthly Return"
    Then I select "Jan 2017" from "MonthlyObligationSelect"
    Then I click on button "NextSection"
    Then I check object with xpath "//*[contains(@id, 'Titlewages')]//div[3]" contents match regex "\(\d{2} \w+ \d{4} - \d{2} \w+ \d{4} / [\w|\s|\W|\(|\)]+\)"

    Examples: 
      | PortalName | UserNameField | PasswordField | Password   |
      | TSSAdmin   | UserNameInput | PasswordInput | Dbresults1 |

  @done
  Scenario Outline: DTSP-501: As an end user, I want the Payroll Tax Registration Form to be updated for Ease of Use
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    #Scenario 3: Rename the Tax Registration Form on the left navigation menu
    Then I see text "Payroll Tax Registration" displayed
    Then I click on "Payroll Tax Registration"
    #Scenario 4: Rename the Page Header of the Payroll Tax Registration Form
    Then I check I am on "Payroll Tax Registration" page
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields                          | Value         |
      | RegistrationAnswer_EmployerName | <CompanyName> |
      | BusinessTradingName             | <CompanyName> |
      | RegistrationAnswer_ACN          | NO            |
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    #Then I select "Direct Post" from "CommunicationMethodId"
    Then I enter the details as
      | Fields                    | Value         |
      | AddressLine1              | TEST          |
      | Address_City              | TEST          |
      | PostCode                  |          3333 |
      | ContactPerson_FirstName   | TEST          |
      | ContactPerson_LastName    | TEST          |
      | ContactPerson_PhoneNumber |    1234567890 |
      | ContactPerson_Email       | TEST@TEST.com |
    #Then I select "AL" from "Address_State"
    Then I click on button "OrgDetailsNextBt"
    Then I wait for "5000" millisecond
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value        |
      | s2id_autogen1_search | Turf Growing |
    Then I click on button "select2-results-1"
    Then I click on button "ACTWagesPaidNextBt"
    Then I wait for "5000" millisecond
    #Scenario 1: Contact Person for Payroll Tax
    Then I see text "Same as Business Contact Person" displayed
    Then I click on "Same as Business Contact Person"
    #Scenario 2: User is a member of a group
    Then I click on button "GroupMember_YES"
    Then I see text "Provide group number" displayed
    And I enter the details as
      | Fields             | Value |
      | ProvideGroupNumber |  1111 |

    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |

  Scenario Outline: DTSP-392: As an end user, I want the Declaration section to be pre-populated on the Summary page so that I don't need to enter my details again
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return Lodgements"
    And I click on "Payroll Tax"
    Then I click on button "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I click on "Monthly Return"
    Then I select "2017" from "tMonthlyObligationSelect"
    Then I click on button "NextSection"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields                                         | Value    |
      | SalariesAndWages                               | 10000000 |
      | BonusesAndCommissions                          |        0 |
      | LodgePayrollAnswer_Commissions                 |        0 |
      | LodgePayrollAnswer_Allowances                  |        0 |
      | LodgePayrollAnswer_DirectorsFees               |        0 |
      | LodgePayrollAnswer_EligibleTerminationPayments |        0 |
      | LodgePayrollAnswer_ValueOfBenefits             |        0 |
      | LodgePayrollAnswer_ShareValue                  |        0 |
      | LodgePayrollAnswer_ServiceContracts            |        0 |
      | LodgePayrollAnswer_Superannuation              |        0 |
      | LodgePayrollAnswer_OtherTaxablePayment         |        0 |
      | LodgePayrollAnswer_ExemptWages                 |        0 |
    Then I click on button "Submit"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName      |
      | item2 | First Name    |
      | item3 | Last Name     |
      | item3 | Position      |
      | item4 | Organisation  |
      | item5 | Contact Phone |
      | item6 | Email Address |
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Organisation         | Position   | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | QUICK SINGLE PTY LTD | Consultant | 04 5678 9767 | katherine.santos@dbresults.com.au |

  @done
  Scenario Outline: DTSP-506: Update default answer to a question on the Payroll Tax Registration form
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | jbradley   |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Payroll Tax Registration"
    Then I wait for "5000" millisecond
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    #Then I select "Direct Post" from "CommunicationMethodId"
    #Then I select "AL" from "Address_State"
    Then I enter the details as
      | Fields                    | Value         |
      | AddressLine1              | TEST          |
      | Address_City              | TEST          |
      | PostCode                  |          3333 |
      | ContactPerson_FirstName   | TEST          |
      | ContactPerson_LastName    | TEST          |
      | ContactPerson_PhoneNumber |    1234567890 |
      | ContactPerson_Email       | TEST@TEST.com |
    Then I click on button "AddressLine1"
    Then I click on button "OrgDetailsNext"
    Then I wait for "5000" millisecond
    Then I check "ACTWagesPaidNextBt" is readonly
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value        |
      | s2id_autogen1_search | Turf Growing |
    Then I click on button "select2-results-1"
    Then I click on button "ACTWagesPaidNextBt"
    Then I see checkbox "AnnualLodgementApproval_NO" as selected

    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |

  @done
  Scenario Outline: DTSP-508: As an end user, I want to see a reminder message on the top of the Payroll Tax Registration form so I know I cannot save an incomplete form
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I click on "Payroll Tax Registration"
    Then I see text "Because you are not logged in, you cannot save an incomplete form for later. Please complete your form and submit it before closing your session." displayed

    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  @done
  Scenario Outline: DTSP-524: As an organisation, I want to force the user to key in every 'dollar' field on the Payroll Tax Lodgement Form so that the user won't miss out any of these fields
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I hit Enter
    Then I click on "Return Lodgements"
    And I click on "Payroll Tax"
    Then I click on button "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    Then I click on button "LodgePayrollAnswer_TypeAnnual"
    Then I select "2015" from "AnnualObligationSelect"
    Then I click on button "NextSection"
    Then I check "SalariesAndWages" contains "$"
    Then I check "BonusesAndCommissions" contains "$"
    Then I check "LodgePayrollAnswer_Commissions" contains "$"
    Then I check "LodgePayrollAnswer_Allowances" contains "$"
    Then I check "LodgePayrollAnswer_DirectorsFees" contains "$"
    Then I check "LodgePayrollAnswer_EligibleTerminationPayments" contains "$"
    Then I check "LodgePayrollAnswer_ValueOfBenefits" contains "$"
    Then I check "LodgePayrollAnswer_ShareValue" contains "$"
    Then I check "LodgePayrollAnswer_ServiceContracts" contains "$"
    Then I check "LodgePayrollAnswer_Superannuation" contains "$"
    Then I check "LodgePayrollAnswer_OtherTaxablePayment" contains "$"
    Then I check "LodgePayrollAnswer_ExemptWages" contains "$"
    Then I enter the details as
      | Fields                                         | Value |
      | SalariesAndWages                               |     0 |
      | BonusesAndCommissions                          |     0 |
      | LodgePayrollAnswer_Commissions                 |     0 |
      | LodgePayrollAnswer_Allowances                  |     0 |
      | LodgePayrollAnswer_DirectorsFees               |     0 |
      | LodgePayrollAnswer_EligibleTerminationPayments |     0 |
      | LodgePayrollAnswer_ValueOfBenefits             |     0 |
      | LodgePayrollAnswer_ShareValue                  |     0 |
      | LodgePayrollAnswer_ServiceContracts            |     0 |
      | LodgePayrollAnswer_Superannuation              |     0 |
      | LodgePayrollAnswer_OtherTaxablePayment         |     0 |
      | LodgePayrollAnswer_ExemptWages                 |     0 |
    Then I click on button "ClaimingACTProportion_Yes"
    Then I check "PayrollAnswer_AustralianWide" contains "$"

    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  ###########################################################################################################
  #################################### PHASE 1.1 ITERATION 1 ################################################
  ###########################################################################################################
  #STORIES DONE:  78, 136, 141, 176, 185, 522, 578, 583, 584, 592, 608, 617, 622
  #CURRENT ITERATION: 1.1
  Scenario Outline: DTSP-78: As an end user, I want to be able to select an ABN and view next payment information and lodge from the Right Navigation Panel on my Basic Dashboard
    #Scenario 1: Business Taxpayer associated with multiple ABNs
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Home"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value  |
      | s2id_autogen1_search | DUSTER |
    Then I click on button "select2-results-1"
    Then I click on "Sign Out"
    #Scenario 2: Business Taxpayer associated with only 1 ABN
    #Given I want to login to portal "<PortalName>"
    #And I enter the details as
    #| Fields        | Value      |
    #| UserNameInput | Test1     |
    #| PasswordInput | <Password> |
    #And I hit Enter
    #Then I check "select2-chosen-1" is readonly
    #Then I click on "Sign Out"
    #Scenario 3: Tax Agent associated with multiple ABNs (i.e. clients)
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | Taxagent4  |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | Chocolate |
    Then I click on button "select2-results-1"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value        |
      | s2id_autogen1_search | Member Check |
    Then I click on button "select2-results-1"
    Then I click on "Sign Out"
    #Scenario 4: Tax Agent associated with only 1 ABN (i.e. client)
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | taxagent3  |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I check "select2-chosen-1" is readonly
    Then I click on "Sign Out"
    #Scenario 5: Display “Next Payment” box
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Home"
    Then I see text "Your Outstanding Tax Returns to Lodge" displayed
    #Scenario 7: User clicks on “View History” button
    # Then I click on "View History"
    Then I click on button with value "View History"
    Then I check I am on "Return History" page
    Then I click on "Home"
    #Scenario 8: User clicks on “Lodge Return” button
    #Then I click on "Lodge Return"
    #Then I click on button with value "Lodge Return"
    #Then I check I am on "Payroll Lodgement Form" page
    #Then I click on "Home"
    Then I click on "Sign Out"
    #Scenario 10: User has no outstanding payment
    #Given I want to login to portal "<PortalName>"
    #And I enter the details as
    #| Fields        | Value      |
    #| UserNameInput | Test2   |
    #| PasswordInput | <Password> |
    #And I hit Enter
    #Then I see text "You do not have any outstanding payments" displayed
    #Scenario 11: User has no transaction history
    #Then I check "BillComparation" is readonly
    #Then I click on "Sign Out"
    #Scenario 9: User has no outstanding lodgement
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Home"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value  |
      | s2id_autogen1_search | SUBMIT |
    Then I click on button "select2-results-1"

    #Then I see text "You do not have any outstanding lodgements" displayed
    #Scenario 11: TODO when 'View History' and 'Lodge Return' buttons have actual ids.
    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  Scenario Outline: DTSP-141: As an end user, I want to be able to view my Recent Transactions on my Basic Dashboard, so that it shows me a quick summary of my recent/closed Lodgements and Payments.
    #Scenarios 1 and 2 are better off manually.
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Home"
    #Scenario 3
    Then I click on button with value "View History"
    Then I check I am on "Return History" page
    Then I click on "Home"
    Then I click on "Sign Out"
    #Scenario 4
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Home"
    #Then I click on "Transaction History"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value  |
      | s2id_autogen1_search | SUBMIT |
    Then I click on button "select2-results-1"
    Then I see text "You do not have any return history available" displayed
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value              |
      | s2id_autogen1_search | GOOD FOR SOMETHING |
    Then I click on button "select2-results-1"
    Then I see text "You do not have any return history available" displayed
    Then I check "BillComparation" is readonly
    Then I click on "Sign Out"
    #Scenario 7
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | Test2      |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Home"
    Then I see text "Please note, as there are currently no taxpayer accounts associated with your login, there is no information to display." displayed
    #Then I click on button "AddABN"
    #Then I switch to frame "0"
    #Then I check "BusinessEntity_ABN" exists
    #Then I check "BusinessEntity_CRN" exists
    #Then I click on button with value "CANCEL"
    #Then I check I am on "Manage Account Details" page
    Then I click on "Sign Out"
    #Scenario 8
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | Taxagent1  |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Home"
    Then I see text "Please note, as there are currently no taxpayer accounts associated with your login, there is no information to display." displayed
    Then I click on "Sign Out"

    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  Scenario Outline: DTSP-185: As an end user, I want to be able to edit my Business Address details on my Tax Registration form
    #Scenario 10 should be tested manually as it regards an email
    #ONHOLD DUE TO DTSP-713
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    #	Scenario 1: User views update left hand Navigation menu items
    # Scenario 2: User views "Tax Registration Updates" sub menu items
    Then I click on "Tax Registration Update"
    Then I see text "Update Business Address" displayed
    Then I see text "Update Contact Details" displayed
    Then I see text "Update Refund Details" displayed
    # Scenario 3: User elects to view "Update Business Address" details form
    Then I click on "Update Business Address"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                                                  |
      | item2 | Taxpayer Details                                          |
      #| item3 | Update Business Address                                   |
      #| item5 | Business Address                                          |
      | item5 | Postal Address                                            |
      | item5 | Address where Business Records are located (Jurisdiction) |
    #		Scenario 4: User elects to edit "Update Business Address" details form
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <BusinessName> |
    Then I click on button "select2-results-1"
    #Then I check "Address_CountryId" is not readonly
    Then I check "Address_AddressLine1" is not readonly
    Then I check "Address_City" is not readonly
    Then I check "Address_State" is not readonly
    Then I check "Address_PostCode" is not readonly
    Then I click on button "NextBT"
    #		Scenario 5: User views 'Tax Registration Update ' Summary page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName      |
      | item3 | Declaration   |
      | item5 | Organisation  |
      | item5 | Contact Phone |
      | item5 | Email Address |
    #		Scenario 6: Submit 'Tax Registration Update ' data to PSRM without errors
    Then I click on button "CorrectInfoDeclared"
    Then I click on button "SubmitBT"
    Then I wait for "20000" millisecond
    Then I see text "Your Update Business Address Request has been successfully submitted. An email has been sent to you for your reference." displayed
    Then I see text "To download the details you have submitted, please click the button below." displayed
    #		Scenario 7: Submit 'Tax Registration Updates 'data to PSRM with errors
    Given I want to login to portal "<PortalName>"
    Then I click on "Tax Registration Update"
    Then I click on "Update Business Address"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <BusinessName> |
    Then I click on button "select2-results-1"
    Then I enter the details as
      | Fields           | Value |
      | Address_PostCode |    33 |
    Then I click on button "NextBT"
    Then I wait for "5000" millisecond
    #Then I see text "Invalid Post Code, should have length 4 and should contain only digits." displayed
    Then I see text "Invalid Postcode. Postcode should be 4 Digits. Please try again." displayed
    #		Scenario 8: User clicks 'Back' on the 'Tax Registration Updates' Summary page
    Then I enter the details as
      | Fields           | Value |
      | Address_PostCode |  3333 |
    #		Scenario 9: User views Tax Registration Updates Confirmation page
    Then I click on button "NextBT"
    Then I check I am on "Update Business Address Summary" page
    Then I click on button with value "Back"
    Then I check I am on "Update Business Address" page
    #		Scenario 11: User selects "Cancel" and common browser message is displayed and the user is re directed to the Dashboard
    Then I enter the details as
      | Fields           | Value |
      | Address_PostCode |  4444 |
    Then I click on button with value "Cancel"
      And I "Accept" windows alert
    #Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "Cancel"
    #Then I click on button with value "Cancel"
    #Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"

    Examples: 
      | PortalName | UserName | Password   | BusinessName        |
      | TSSAdmin   | jbradley | Dbresults1 | DESIGNATE PTY. LTD. |

  @review
  Scenario Outline: DTSP-522: As a end user I want the settings page updated so I can understand what the settings page is used for
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    #Scenario 1: User views updated left hand navigation menu
    Then I see text "User Profile" displayed
    #Scenario 2: User selects 'User Profile' sub-menu item on the left hand navigation menu
    Then I click on "User Profile"
    Then I check I am on "View User Profile" page
    Then I see text "Contact Details" displayed
    Then I see text "Edit User Profile" displayed
    Then I see text "Business Tax Payer" not displayed
    Then I see text "Choose a Tax Agent" not displayed
    #Scenario 3: User selects 'Edit User Profile' on the 'View User Profile' page
    Then I click on button "EditBT"
    Then I check I am on "Edit User Profile" page
    Then I see text "Contact Details" displayed

    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  Scenario Outline: DTSP-567: As an end user, I don't want to see any tax calculations while I am filling out the Payroll Tax Lodgement Form until they are retrieved from PSRM and populated on the Lodgement Summary page
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return Lodgements"
    And I click on "Payroll Tax"
    Then I click on button "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    Then I click on "Annual Reconciliation"
    Then I select "2016" from "AnnualObligationSelect"
    Then I click on button "NextSection"
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
    #Scenario 1: Remove calculated fields in the "Wages / Reconciliation" section
    # Then I see text "ACT Taxable Wages" not displayed
    Then I see text "Tax-Free Threshold" not displayed
    Then I see text "Taxable wages" not displayed
    Then I see text "Tax Payable" not displayed
    Then I click on button "wtSubmitBT"
    #Scenario 2: Remove calculated fields in the "Total Amounts" section
    Then I see text "Amount Payable / Refund Amount Equals" not displayed

    #Scenario 3 is currently blocked by bug DTSP-684
    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

    Examples: 
      | PortalName | UserName | Password   | ABN         | CRN    |
      | TSSAdmin   | jbradley | Dbresults1 | 13058370433 | 400014 |

  Scenario Outline: DTSP-583: As an end user, I want to be able to edit my Contact Person details on my Tax Registration form
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    #	Scenario 1: User views update left hand Navigation menu items
    # Scenario 2: User views "Tax Registration Updates" sub menu items
    Then I click on "Tax Registration Update"
    Then I see text "Update Business Address" displayed
    Then I see text "Update Contact Details" displayed
    Then I see text "Update Refund Details" displayed
    # Scenario 3: User elects to view "Update Business Address" details form
    Then I click on "Update Contact Details"
    Then I check I am on "Update Contact Details" page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName         |
      | item2 | Taxpayer Details |
    #| item3 | Update Business Address                                   |
    #| item5 | Business Address                                          |
    #| item5 | Update Contact Details                                           |
    #		Scenario 4: User elects to edit "Update Business Address" details form
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <BusinessName> |
    Then I click on button "select2-results-1"
    Then I check "ContactPerson_FirstName" is not readonly
    Then I check "ContactPerson_LastName" is not readonly
    Then I check "ContactPerson_PhoneNumber" is not readonly
    Then I check "ContactPerson_Email" is not readonly
    Then I check "Address_AddressLine7" is not readonly
    Then I check "Address_City4" is not readonly
    Then I check "Address_PostCode4" is not readonly
    #Then I check "Address_AddressLine7" is not readonly
    Then I click on button with value "Next"
  #  Then I click on button with value "Next"
    #		Scenario 5: User views 'Tax Registration Update ' Summary page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName      |
      | item3 | Declaration   |
      | item5 | Organisation  |
      | item5 | Contact Phone |
      | item5 | Email Address |
    #		Scenario 6: Submit 'Tax Registration Update ' data to PSRM without errors
    Then I click on button "CorrectInfoDeclared"
    Then I click on button "SubmitBT"
    Then I see text "Your Payroll Tax Update Contact Details Request has been successfully submitted. An email has been sent to you for your reference." displayed
    Then I see text "To download the details you have submitted, please click the button below." displayed
    #		Scenario 7: Submit 'Tax Registration Updates 'data to PSRM with errors
    Given I want to login to portal "<PortalName>"
    Then I click on "Tax Registration Update"
    Then I click on "Update Contact Details"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <BusinessName> |
    Then I click on button "select2-results-1"
    Then I enter the details as
      | Fields            | Value |
      | Address_PostCode4 |    33 |
    Then I click on button "NextBT"
    Then I wait for "5000" millisecond
    Then I see text "Invalid Post Code, should have length 4 and should contain only digits." displayed
    #		Scenario 8: User clicks 'Back' on the 'Tax Registration Updates' Summary page
    Then I enter the details as
      | Fields            | Value |
      | Address_PostCode4 |  3333 |
    #		Scenario 9: User views Tax Registration Updates Confirmation page
    Then I click on button "NextBT"
    Then I check I am on "Update Contact Details Summary" page
    Then I click on button with value "Back"
    Then I check I am on "Update Contact Details" page
    #		Scenario 11: User selects "Cancel" and common browser message is displayed and the user is re directed to the Dashboard
    Then I enter the details as
      | Fields           | Value |
      | Address_PostCode |  4444 |
    Then I click on button with value "Cancel"
 And I "Reject" windows alert
    #Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "Cancel"
    Then I click on button with value "Cancel"
   And I "Accept" windows alert
    Examples: 
      | PortalName | UserName | Password   | BusinessName        |
      | TSSAdmin   | jbradley | Dbresults1 | DESIGNATE PTY. LTD. |
   @TSSRegression
  Scenario Outline: DTSP-592: As an end user, I want to be able to edit my Refund details on my Tax Registration form
    #Scenario 10 should be tested manually as it regards an email
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    #	Scenario 1: User views update left hand Navigation menu items
    # Scenario 2: User views "Tax Registration Updates" sub menu items
    Then I click on "Tax Registration Update"
    Then I see text "Update Business Address" displayed
    Then I see text "Update Contact Details" displayed
    Then I see text "Update Refund Details" displayed
    # Scenario 3: User elects to view "Update Business Address" details form
    Then I click on "Update Refund Details"
    Then I check I am on "Update Refund Details" page
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <BusinessName> |
    Then I click on button "select2-results-1"
    #Then I click on button "Refunds_YES"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                        |
      | item2 | Taxpayer Details                |
      | item3 | Set up bank account for refunds |
    #| item5 | BSB                                          |
    #| item5 | Bank Account Number                                            |
    #| item5 | Bank Account Name |
    #		Scenario 4: User elects to edit "Update Business Address" details form
    Then I check "Answer_OrganizationalName" is not empty
    Then I check "Answer_ABN" is not empty
    Then I check "Answer_CRN" is not empty
    #Then I check "Address_State" is not readonly
    #Then I check "Address_PostCode" is not readonly
    Then I click on button "NextBT"
    Then I wait for "5000" millisecond
    #		Scenario 5: User views 'Tax Registration Update ' Summary page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName      |
      | item3 | Declaration   |
      | item5 | Organisation  |
      | item5 | Contact Phone |
      | item5 | Email Address |
    #		Scenario 6: Submit 'Tax Registration Update ' data to PSRM without errors
    Then I click on button "CorrectInfoDeclared"
    Then I click on button with value "Submit"
    Then I wait for "5000" millisecond
    Then I see text "Your Payroll Tax Update Refund Details Request has been successfully submitted. An email has been sent to you for your reference." displayed
    Then I see text "To download the details you have submitted, please click the button below." displayed
    #		Scenario 7: Submit 'Tax Registration Updates 'data to PSRM with errors
    Given I want to login to portal "<PortalName>"
    Then I click on "Tax Registration Update"
    Then I click on "Update Refund Details"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <BusinessName> |
    Then I click on button "select2-results-1"
    Then I click on button "Refunds_YES"
    Then I enter the details as
      | Fields                   | Value     |
      | Answer_BSB               |        33 |
      | Answer_BankAccountNumber | 123123123 |
      | Answer_BankAccountName   | TEST      |
    Then I click on button "NextBT"
    Then I wait for "5000" millisecond
    #Then I see text "Invalid BSB. BSB Should be 6 digits. Please try again." displayed
    #Then I see text "Invalid BSB. BSB Should be 6 digits. Please try again." displayed
    #		Scenario 8: User clicks 'Back' on the 'Tax Registration Updates' Summary page
    Then I enter the details as
      | Fields     | Value  |
      | Answer_BSB | 333333 |
    #		Scenario 9: User views Tax Registration Updates Confirmation page
    Then I click on button "NextBT"
    Then I check I am on "Update Refund Details Summary" page
    Then I click on button with value "Back"
    Then I check I am on "Update Refund Details" page
    #		Scenario 11: User selects "Cancel" and common browser message is displayed and the user is re directed to the Dashboard
    Then I enter the details as
      | Fields     | Value  |
      | Answer_BSB | 444444 |
    Then I click on button with value "Cancel"
        And I "Reject" windows alert
    Then I click on button with value "Cancel"
   And I "Accept" windows alert

    Examples: 
      | PortalName | UserName | Password   | BusinessName        |
      | TSSAdmin   | jbradley | Dbresults1 | DESIGNATE PTY. LTD. |

  #@dolater
  #Scenario Outline: DTSP-608: As a user I want to choose a Tax Payer's ABN so that those details are populated on forms
  #Scenario 2: Business Taxpayer associated with multiple ABNs
  #Given I want to login to portal "<PortalName>"
  #And I enter the details as
  #| Fields        | Value      |
  #| UserNameInput | <UserName> |
  #| PasswordInput | <Password> |
  #And I hit Enter
  #Then I click on "Return Lodgements"
  #Then I click on "
  #Then I click on "Payroll Tax Lodgement"
  #Then I click on button with value "Discard"
  #Then "<Item>" is displayed as "<ItemName>"
  #| Item  | ItemName                         |
  #| text1 | Tax Payer Details                |
  #| text1 | Choose a Tax Payer ABN           |
  #| text2 | Organisational Name              |
  #| text2 | Australian Business Number (ABN) |
  #| text2 | Client Reference Number (CRN)    |
  #| text2 | Return Type                      |
  #| text2 | Monthly Return                   |
  #| text2 | Annual Reconciliation            |
  #Then I click on button "select2-chosen-1"
  #Then I enter the details as
  #| Fields               | Value         |
  #| s2id_autogen1_search | Active Bottle |
  #Then I click on button "select2-results-1"
  #Then I click on button "select2-chosen-1"
  #Then I enter the details as
  #| Fields               | Value    |
  #| s2id_autogen1_search | NAVY PTY |
  #Then I click on button "select2-results-1"
  #Then I click on "Sign Out"
  #Scenario 3: Business Taxpayer associated with ONLY one ABN
  #Given I want to login to portal "<PortalName>"
  #And I enter the details as
  #| Fields        | Value      |
  #| UserNameInput | camido     |
  #| PasswordInput | <Password> |
  #And I hit Enter
  #Then I click on "Payroll Tax Lodgement"
  #Then I click on button with value "Discard"
  #Then I check "select2-chosen-1" is readonly
  #Then "Answer_OrganizationalName" displays "AUTOLINE PTY LTD" by default
  #Then I check "Answer_ABN" contains "50600468817"
  #Then I check "Answer_CRN" contains "400011"
  #Then I click on "Sign Out"
  #Scenario 4: Tax Agent associated with multiple ABN (i.e. clients)
  #Given I want to login to portal "<PortalName>"
  #And I enter the details as
  #| Fields        | Value          |
  #| UserNameInput | test_taxagent1 |
  #| PasswordInput | <Password>     |
  #And I hit Enter
  #Then I click on "Payroll Tax Lodgement"
  #Then I click on button with value "Discard"
  #Then I click on button "select2-chosen-1"
  #Then I enter the details as
  #| Fields               | Value |
  #| s2id_autogen1_search | Green |
  #Then I click on button "select2-results-1"
  #Then I click on button "select2-chosen-1"
  #Then I enter the details as
  #| Fields               | Value  |
  #| s2id_autogen1_search | Domain |
  #Then I click on button "select2-results-1"
  #Then I click on "Sign Out"
  #Scenario 5: Tax Agent associated with ONLY one ABN (i.e. clients)
  #Given I want to login to portal "<PortalName>"
  #And I enter the details as
  #| Fields        | Value      |
  #| UserNameInput | camido     |
  #| PasswordInput | <Password> |
  #And I hit Enter
  #Then I click on "Payroll Tax Lodgement"
  #Then I click on button with value "Discard"
  #Then I check "select2-chosen-1" is readonly
  #Then "Answer_OrganizationalName" displays "AUTOLINE PTY LTD" by default
  #Then I check "Answer_ABN" contains "50600468817"
  #Then I check "Answer_CRN" contains "400011"
  #Then I click on "Sign Out"
  #Scenario 6:
  #Given I want to login to portal "<PortalName>"
  #And I enter the details as
  #| Fields        | Value      |
  #| UserNameInput | <UserName> |
  #| PasswordInput | <Password> |
  #And I hit Enter
  #Then I click on "Payroll Tax Lodgement"
  #Then I click on button with value "Discard"
  #Then I click on button "select2-chosen-1"
  #Then I enter the details as
  #| Fields               | Value         |
  #| s2id_autogen1_search | Active Bottle |
  #Then I click on button "select2-results-1"
  #Then I click on button "select2-chosen-1"
  #Then I enter the details as
  #| Fields               | Value    |
  #| s2id_autogen1_search | NAVY PTY |
  #Then I click on button "select2-results-1"
  #Then I click on "Annual Reconciliation"
  #Then I select "2015" from "AnnualObligationSelect"
  #Then I click on button "NextSection"
  #Then I click on button "MonthlyReturnBackBt"
  #Then I check "Answer_OrganizationalName" is readonly
  #Then I check "Answer_ABN" is readonly
  #Then I check "Answer_CRN" is readonly
  #Then I click on "Sign Out"
  #Scenario 7: Business Tax Payer views Payroll Tax Lodgement with no associated ABN's
  #Given I want to login to portal "<PortalName>"
  #And I enter the details as
  #| Fields        | Value      |
  #| UserNameInput | ccover     |
  #| PasswordInput | <Password> |
  #And I hit Enter
  #Then I click on "Payroll Tax Lodgement"
  #Then I see text "Please note, as there are no ABN's associated to your account, we are unable to display any information." displayed
  #Then I see text "Add an ABN to my Account" displayed
  #Then I click on "Sign Out"
  #Scenario 8: Tax Agent views Payroll Tax Lodgement with no associated ABN's
  #Given I want to login to portal "<PortalName>"
  #And I enter the details as
  #| Fields        | Value          |
  #| UserNameInput | test_taxagent3 |
  #| PasswordInput | <Password>     |
  #And I hit Enter
  #Then I click on "Payroll Tax Lodgement"
  #Then I see text "Please note, as there are no ABN's associated to your account, we are unable to display any information." displayed
  #Then I see text "Add an ABN to my Account" displayed
  #Then I click on "Sign Out"
  #
  #Examples:
  #| PortalName | UserName | Password   |
  #| TSSAdmin   | jbradley | Dbresults1 |
  Scenario Outline: DTSP-622: As an end user (Business Tax Payer), I want to be able to manage tax details
    #NOTE: DO SCENARIOs 6 and 8 manually
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Manage Tax Agent"
    #Scenario 1: Display Manage Tax Details page (Business Tax Payer associated to One ABN)
    #Scenario 2: Display Manage Tax Details page (Business Tax Payer associated to Multiple ABNs)
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName          |
      | item2 | ABN               |
      | item3 | CRN               |
      | item4 | ORGANISATION NAME |
      | item5 | TAX AGENT         |
    #Scenario 4: Display the “Edit Tax Agent” pop up window
    Then I click on button "EditABN"
    Then I switch to frame "0"
    Then I see text "ABN" displayed
    Then I see text "CRN" displayed
    Then I see text "Organisation Name" displayed
    Then I see text "Tax Agent" displayed
    #Scenario 5: Edit Tax Agent nomination of an ABN
    Then I click on button "SelectTaxAgent2"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <SearchString> |
    Then I click on button "select2-results-1"
    Then I click on button "SaveBtn"
    Then I check I am on "Manage Tax Agent" page
    #Scenario 7: Display the Add Additional ABN page
    Then I click on button "AddABN"
    Then I switch to frame "0"
    Then I see text "ABN" displayed
    Then I see text "CRN" displayed
    #Scenario 10: Mandatory Information on the “Add Additional ABN” page
    Then I check "SaveBtn" is readonly
    #Scenario 9: Add an additional ABN to the Business Tax Payer account [unhappy path]
    And I enter the details as
      | Fields             | Value       |
      | BusinessEntity_ABN | 11111111111 |
      | BusinessEntity_CRN |      111111 |
    Then I click on button "SaveBtn"
    Then I see text "Invalid ABN or CRN" displayed

    Examples: 
      | PortalName | UserName | Password   | SearchString |
      | TSSAdmin   | jbradley | Dbresults1 | DB RESULTS   |

  ###########################################################################################################
  #################################### PHASE 1.1 ITERATION 2 ################################################
  ###########################################################################################################
  #DONE: 101, 105, 116, 124, 595, 596, 647, 682
  #MANUAL: 580, 601, 607, 648, 651,
  @review
  Scenario Outline: DTSP-101: As an end user, I want to be able raise an Objection Request so that I can object on the tax amount, penalty, interest and decision on previous objections.
    #Scenarios 4, 5 and 6 must be done manually
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Service Requests"
    Then I click on "Objection Request"
    #Scenario 1: Display "Objection Request" Form
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "Objection_Comments" is readonly
    Then I check "ObjectionOutOfTimeYES" is readonly
    Then I check "ObjectionOutOfTimeNO" is readonly
    Then I check "CheckTaxAmount" is readonly
    Then I check "CheckPenalty" is readonly
    Then I check "CheckInterest" is readonly
    Then I check "CheckDecision" is readonly
    #Scenario 2: "Objection Information" section displayed on the "Objection Request" Form
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | Designate |
    Then I click on button "select2-results-1"
    Then I check "Objection_Comments" is readonly
    Then I check "ObjectionOutOfTimeYES" is not readonly
    Then I check "ObjectionOutOfTimeNO" is not readonly
    Then I check "CheckTaxAmount" is not readonly
    Then I check "CheckPenalty" is not readonly
    Then I check "CheckInterest" is not readonly
    Then I check "CheckDecision" is not readonly
    #Scenario 3: "Objection Request" Summary page
    Then I click on button "ObjectionOutOfTimeYES"
    Then I enter the details as
      | Fields             | Value                  |
      | Objection_Comments | ObjectionComment       |
      | LodgeFailureReason | LodgementFailureReason |
    Then I click on button "CheckPenalty"
    Then I click on button with value "Next"
    Then I check I am on "Objection Request Summary" page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                                          |
      | item2 | Organisation Name                                 |
      | item3 | Australian Business Number (ABN)                  |
      | item4 | Client Reference Number (CRN)                     |
      | item5 | Subject of Objection                              |
      | item6 | Is the Objection out of time                      |
      | item7 | Reason for failing to lodge the objection on time |
      | item7 | Comments                                          |
    Then I check object with xpath "//*[contains(@id, 'ObjectionInformation')]//..//tr[1]//td[2]" contains "Payroll Tax"
    Then I check object with xpath "//*[contains(@id, 'ObjectionInformation')]//..//tr[2]//td[2]" contains "Penalty"
    Then I check object with xpath "//*[contains(@id, 'ObjectionInformation')]//..//tr[3]//td[2]" contains "Yes"
    Then I check object with xpath "//*[contains(@id, 'ObjectionInformation')]//..//tr[4]//td[2]" contains "LodgementFailureReason"
    Then I check object with xpath "//*[contains(@id, 'ObjectionInformation')]//..//tr[5]//td[2]" contains "ObjectionComment"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName      |
      | item2 | First Name    |
      | item3 | Last Name     |
      | item3 | Position      |
      | item4 | Organisation  |
      | item5 | Contact Phone |
      | item6 | Email Address |
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position            | Organisation | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | DESIGNATE PTY. LTD. | Consultant   | 04 5678 9767 | katherine.santos@dbresults.com.au |

  Scenario Outline: DTSP-116: As an end user, I want to be able to submit a Payroll Tax Registration Cancellation Request so that I can cancel my current
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Service Requests"
    Then I click on "Tax Registration Cancellation"
    #Scenario 1: Display "Tax Registration Cancellation" Form
    Then I check "OrganizationalName" is empty
    Then I check "PayrollAnswer_ABN" is empty
    Then I check "PayrollAnswer_CRN" is empty
    Then I check "CancellationStartDate" is readonly
    #Scenario 2: "Payroll Tax Cancellation Information" section becomes
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I check "CancellationStartDate" is not readonly
    Then I check "ReasonDescription" is not readonly
    ##Scenario 4: Error display
    #| CancellationStartDate | 20517 |
    Then I click on button "CancellationStartDate"
    Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
    Then I enter the details as
      | Fields            | Value |
      | ReasonDescription | TEST  |
    Then I click on button with value "Next"
    Then I check I am on "Tax Cancellation Request Summary" page
    #Scenario 5: Payroll Tax Cancellation Submission
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    Then I click on button "CorrectInfoDeclared"
    Then I click on button with value "Submit"
    Then I wait for "5000" millisecond
    #Then I see text "Your Payroll Tax Registration Cancellation Request has been successfully submitted. An email has been sent to you for your reference." displayed
    Then I see text "To download the details you have submitted, please click the button below." displayed
    Then I check I am on "Tax Cancellation Request Confirmation" page

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Organisation | Position   | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | AQUA PTY LTD | Consultant | 04 5678 9767 | katherine.santos@dbresults.com.au |

  @done
  Scenario Outline: DTSP-124: As an end user, I want to be able to submit an Annual Lodgement Request so that I can submit a request to change my lodgement frequency from monthly to annual
    #Title error in Annual Lodgement Request Summary page, has been flagged
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Service Requests"
    Then I click on "Annual Lodgement Request"
    Then I check "OrganizationalName" is empty
    Then I check "PayrollAnswer_ABN" is empty
    Then I check "PayrollAnswer_CRN" is empty
    Then I check "YearCombo" is readonly
    Then I check "MonthCombo" is readonly
    Then I check "AnnualLodgementRequestJustification" is readonly
    #Scenario 2: "Payroll Tax Cancellation Information" section becomes
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    Then I check "YearCombo" is not readonly
    Then I check "MonthCombo" is readonly
    Then I check "AnnualLodgementRequestJustification" is not readonly
    ##Scenario 4: Error display
    #Scenario 3: "Payroll Tax Cancellation" Summary page
    Then I select "2018" from "YearCombo"
    Then I click on button "MonthCombo"
    Then I click on "Jan"
    And I enter the details as
      | Fields                              | Value |
      | AnnualLodgementRequestJustification | TEST  |
    Then I click on button with value "Next"
    #Scenario 5: Payroll Tax Cancellation Submission
    Then I check I am on "Annual Lodgement Request Summary" page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                               |
      | item2 | Organisation Name                      |
      | item3 | Australian Business Number (ABN)       |
      | item4 | Client Reference Number (CRN)          |
      | item5 | Requested Effective Date               |
      | item6 | Annual Lodgement Request Justification |
      | item7 | Declaration                            |
      | item7 | Organisation                           |
      | item7 | Contact Phone                          |
      | item7 | Email Address                          |
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    Then I click on button "CorrectInfoDeclared"
    Then I click on button with value "Submit"
    Then I wait for "5000" millisecond
    #Then I see text "Your Payroll Tax Registration Cancellation Request has been successfully submitted. An email has been sent to you for your reference." displayed
    #Then I see text "To download the details you have submitted, please click the button below." displayed
    Then I check I am on "Annual Lodgement Request Confirmation" page

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position            | Organisation | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | DESIGNATE PTY. LTD. | Consultant   | 04 5678 9767 | katherine.santos@dbresults.com.au |

  @review
  Scenario Outline: DTSP-127: As an end user, I want to be able to submit a Liquidation Advice service request
    #Known error relating to the title of Liquidation Advice Summary and Confirmation page. Has been flagged
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Service Requests"
    Then I click on "Liquidation Advice"
    Then I check "OrganizationalName" is empty
    Then I check "PayrollAnswer_ABN" is empty
    Then I check "PayrollAnswer_CRN" is empty
    Then I check "FirstName" is readonly
    Then I check "LastName" is readonly
    Then I check "PhoneNumber" is readonly
    Then I check "ContactPerson_Email" is readonly
    Then I check "Address_AddressLine" is readonly
    Then I check "Address_City4" is readonly
    Then I check "Address_PostCode" is readonly
    # Then I check "CommunicationMethodId" is readonly
    Then I check "CountryId4" is readonly
    Then I check "Address_State4" is readonly
    #Scenario 2: "Payroll Tax Cancellation Information" section becomes
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    Then I check "FirstName" is not readonly
    Then I check "LastName" is not readonly
    Then I check "PhoneNumber" is not readonly
    Then I check "ContactPerson_Email" is not readonly
    Then I check "Address_AddressLine" is not readonly
    Then I check "Address_City4" is not readonly
    Then I check "Address_PostCode" is not readonly
    #Then I check "CommunicationMethodId" is not readonly
    Then I check "CountryId4" is not readonly
    Then I check "Address_State4" is not readonly
    ##Scenario 4: Error display
    #Then I click on button "LiquidationStartDate"
    #Then I click on "20170520"
    #Then I click on button "ContactPerson_CommunicationMethodId"
    #Then I click on "Email"
    Then I select "Victoria" from "Address_State4"
    Then I enter the details as
      | Fields               | Value |
      | LiquidationStartDate | 20517 |
      | FirstName            | TEST  |
      | LastName             | TEST  |
      | PhoneNumber          | 33 3  |
      | ContactPerson_Email  | TES   |
      | Address_AddressLine  | TesT  |
      | Address_City4        | TEST  |
      | Address_PostCode     |    33 |

    # CAN NO LONGER DO THE FOLLOWING DUE TO UPLOADING REQUIREMENTS
    #Then I click on button with value "Next"
    #Then I see text "Invalid Phone Number. Phone Number should be 10 digits. Please try again." displayed
    #Then I see text "Invalid Postcode. Postcode should be 4 Digits. Please try again." displayed
    #Then I see text "Incorrect Email Format." displayed
    #Scenario 3: "Payroll Tax Cancellation" Summary page
    #Then I enter the details as
    #| Fields              | Value           |
    #| FirstName           | TEST            |
    #| LastName            | TEST            |
    #| PhoneNumber         | 33 33333333     |
    #| ContactPerson_Email | TES@asdsdaf.com |
    #| Address_AddressLine | TesT            |
    #| Address_City4       | TEST            |
    #| Address_PostCode    |      3333333333 |
    #Then I click on button with value "Next"
    #Then I check I am on "Liquidation Advice Summary" page
    #Then "<Item>" is displayed as "<ItemName>"
    #| Item  | ItemName                         |
    #| item2 | Organisation Name                |
    #| item3 | Australian Business Number (ABN) |
    #| item4 | Client Reference Number (CRN)    |
    #| item5 | Liquidation Start Date           |
    #| item6 | Liquidator Contact Details       |
    #| item2 | First Name                       |
    #| item3 | Last Name                        |
    #| item3 | Position                         |
    #| item4 | Organisation                     |
    #| item5 | Contact Phone                    |
    #| item6 | Email Address                    |
    #Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    #Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    #Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Position>"
    #Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Organisation>"
    #Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    #Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    #Scenario 5: Payroll Tax Cancellation Submission
    #Then I click on button "CorrectInfoDeclared"
    #Then I click on button with value "Submit"
    #Then I wait for "5000" millisecond
    #Then I see text "Liquidation Advice Confirmation" displayed
    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position            | Organisation | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | DESIGNATE PTY. LTD. | Consultant   | 04 5678 9767 | katherine.santos@dbresults.com.au |

  Scenario Outline: DTSP-595: As an end user, I want to be able to add/edit/remove ACT group members to my Payroll Tax Group
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Group Management"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value                |
      | s2id_autogen1_search | QUICK SINGLE PTY LTD |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    #Scenario 1: Display "Add ACT Group Member" button
    #Scenario 2: Display "Add ACT Group Member" button
    Then I click on button with value "Create Group"
    Then I wait for "5000" millisecond
    Then I switch to frame "1"
    Then I click on button "GroupRoleComboBox"
    Then I click on "Group Member"
    Then I click on button "GroupReasonComboBox"
    Then I click on "Common Control"
    Then I click on button with value "SAVE"
    Then I check "AddACTPopUp" exists
    Then I click on button "AddACTPopUp"
    Then I switch to frame "1"
    #Scenario 3: Pop up
    Then I see text "ABN" displayed
    Then I see text "Group Role" displayed
    Then I see text "Grouping Reason" displayed
    Then I see text "Other Grouping Reason" displayed
    Then I click on button "GroupRoleComboBox"
    Then I click on "Group Member"
    Then I select "Common Control" from "GroupReasonComboBox"
    And I enter the details as
      | Fields        | Value       |
      | GrpMember_ABN | 78602736943 |
    #Scenario 4: Save button activated
    Then I check "PopUpSaveBT" is not readonly
    #Scenario 5: Successfully validated ABN in PSRM
    Then I click on button "PopUpSaveBT"
    #Scenario 6: Unsuccessfully validated ABN in PSRM
    Then I wait for "4000" millisecond
    Then I click on button "AddACTPopUp"
    Then I switch to frame "1"
    Then I click on button "GroupRoleComboBox"
    Then I click on "Group Member"
    Then I select "Common Control" from "GroupReasonComboBox"
    And I enter the details as
      | Fields        | Value       |
      | GrpMember_ABN | 22222222222 |
    Then I click on button "PopUpSaveBT"
    Then I see text "Please enter an ABN that is registered for Payroll Tax" displayed
    #Scenario 14: Adding a Group Member validations
    Then I wait for "4000" millisecond
    Then I click on button "AddACTPopUp"
    Then I switch to frame "1"
    Then I click on button "GroupRoleComboBox"
    Then I click on "Group Member"
    Then I select "Common Control" from "GroupReasonComboBox"
    And I enter the details as
      | Fields        | Value       |
      | GrpMember_ABN | 85085664197 |
    Then I click on button "PopUpSaveBT"
    Then I wait for "4000" millisecond
    Then I see text "Please enter an ABN that is not already part of a Payroll Tax Group." displayed
    #Scenario 15: Group Member (lodging for itself)
    #Then I click on button "l03_wtPopupLink"
    #Then I switch to frame "1"
    #Then I click on button "GroupRoleComboBox"
    #Then I click on "Group Member (lodging itself)"
    #Then I select "Common Control" from "GroupReasonComboBox"
    #Then I click on button "PopUpSaveBT"
    #Then I click on button "ctl03_wt83"
    #Then I see text "The nominated DGE cannot have a Group Role of 'Group Member (lodging itself)" displayed
    #Scenario 7: Remove ACT Group Member
    Then I click on object with xpath "(//table[contains(@id, 'TableACTGroupMembers')]//tr//td//a)[2]"
    Then I see "Do you really want to remove the organisation from your Payroll Tax Group?" displayed on popup and I click "OK"
    Then I see text "FORMULA CHARGER PTY. LTD." not displayed
    Then I click on object with xpath "(//table[contains(@id, 'TableACTGroupMembers')]//tr//td//a)[2]"
    Then I see "Do you really want to remove the organisation from your Payroll Tax Group?" displayed on popup and I click "OK"
    #Scenario 16: DGE
    #Then I click on button "l03_wtPopupLink"
    #
    #Then I switch to frame "1"
    #Then I click on button "GroupRoleComboBox"
    #Then I click on "Group Member (lodging itself)"
    #Then I select "Common Control" from "GroupReasonComboBox"
    #Then I click on button "PopUpSaveBT"
    #Then I click on button "ctl03_wt83"
    #Then I see text "The nominated DGE cannot have a Group Role of 'Group Member (lodging itself)" displayed
    #
    #
    #Scenario 12: User attempts to remove themselves
    Then I select "2018" from "YearCombo"
    Then I select "Jan" from "MonthCombo"
    Then I click on button with value "Next"

    #popup has extraneous spacing
    #Then I see "You have elected to remove yourself from this Payroll Tax Group. Do you wish to proceed?" displayed on popup and I click "Cancel"
    #Scenarios 5, 6, 9, 10, 11 are best done manually
    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  @done
  Scenario Outline: DTSP-596: As a Payroll Tax Group member, I want to be able to view the details of my Payroll Tax Group
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Group Management"
    #Scenario 1: Display "Group Management" Form
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                         |
      | item2 | Choose a Taxpayer                |
      | item3 | Organisation Name                |
      | item4 | Australian Business Number (ABN) |
      | item5 | Client Reference Number (CRN)    |
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    #Scenario 4: "Group Management" "Update Group" button
    Then I click on button with value "Update Group"
    Then I click on button with value "Add Act Group Member"
    Then I switch to frame "1"
    Then I click on button with value "CANCEL"
    Then I click on button with value "Add Non-Act Group Member"
    Then I switch to frame "1"
    Then I click on button with value "CANCEL"
    Then I click on "Group Management"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on button with value "Update Group"
    Then I wait for "5000" millisecond
    #Scenario 5: View no "ACT Group Members"
    Then I click on object with xpath "(//table[contains(@id, 'TableACTGroupMembers')]//tr//td//a)[2]"
    Then I see "Do you really want to remove the organisation from your Payroll Tax Group?" displayed on popup and I click "OK"
    Then I click on object with xpath "(//table[contains(@id, 'TableACTGroupMembers')]//tr//td//a)[2]"
    Then I see "Do you really want to remove the organisation from your Payroll Tax Group?" displayed on popup and I click "OK"
    Then I click on object with xpath "(//table[contains(@id, 'TableACTGroupMembers')]//tr//td//a)[2]"
    Then I see "Do you really want to remove the organisation from your Payroll Tax Group?" displayed on popup and I click "OK"
    Then I see text "You currently do not have any members in this category" displayed
    #Scenario 6: View no "Non-ACT Group Members"
    Then I see text "You currently do not have any members in this category" displayed
    #Scenario 7: Selected ABN not part of payroll tax group
    Then I click on "Group Management"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | Bye Debts |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I see text "You are not currently a part of a Payroll Tax Group" displayed
    Then I click on button with value "Create Group"
    Then I wait for "5000" millisecond
    Then I switch to frame "1"
    Then I click on button "GroupRoleComboBox"
    Then I click on "Group Member (lodging itself)"
    Then I select "Common Control" from "GroupReasonComboBox"
    Then I click on button "PopUpSaveBT"
    #Scenario 13: Page Title
    Then I click on "Group Management"
    #Then I see text "Payroll Tax Group Summary" displayed
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | Bye Debts |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    #Scenario 10: Adding selected ABN to group first
    Then I click on button with value "Create Group"
    Then I wait for "5000" millisecond
    Then I switch to frame "1"
    Then I check "GrpMember_ABN" contains "22150972535"
    Then I check "RichWidgets_wt18_block_wtMainContent_wt13" contains "Bye Debts Pty Ltd"
    Then I select "Group Member" from "GroupRoleComboBox"
    Then I select "Common Control" from "GroupReasonComboBox"

    #Scenarios 2, 3, 8, 9, 12 are best done manually
    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  Scenario Outline: DTSP-646: Update phone number field validation rules to reflect Australian numbers and allow future dates selection in PayRoll Tax Registration form
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    #Scenario 1: User enters Phone Number on any TSS forms
    Then I click on "Payroll Tax Registration"
    Then I wait for "5000" millisecond
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    And I enter the details as
      | Fields                    | Value      |
      | ContactPerson_PhoneNumber | 3333333333 |
    Then I check "ContactPerson_PhoneNumber" contents match regex "\d\d \d\d\d\d \d\d\d\d"
    Then I enter the details as
      | Fields                    | Value         |
      | AddressLine1              | TEST          |
      | Address_City              | TEST          |
      | ContactPerson_FirstName   | TEST          |
      | ContactPerson_LastName    | TEST          |
      | ContactPerson_Email       | TEST@TEST.com |
      | PostCode                  |          3333 |
      | ContactPerson_PhoneNumber |    1234567890 |
    #Then I select "AL" from "Address_State"
    Then I click on button "AddressLine1"
    # Then I see text "Title" not displayed
    Then I click on button "OrgDetailsNextBt"
    #Scenario 1:User should see 4 digit codes after industry name (retrieved from PSRM) under the Business Activity Category dropdown
    Then I see text "Business Activity Elsewhere in Australia" displayed
    #Then I click on button "ACTWagesPaidBackBt"
    Then I click on "Payroll Tax Registration"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Then I wait for "5000" millisecond
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    And I enter the details as
      | Fields                    | Value      |
      | ContactPerson_PhoneNumber | 3333333333 |
    Then I check "ContactPerson_PhoneNumber" contents match regex "\d\d \d\d\d\d \d\d\d\d"
    Then I enter the details as
      | Fields                    | Value         |
      | AddressLine1              | TEST          |
      | Address_City              | TEST          |
      | ContactPerson_FirstName   | TEST          |
      | ContactPerson_LastName    | TEST          |
      | ContactPerson_Email       | TEST@TEST.com |
      | PostCode                  |          3333 |
      | ContactPerson_PhoneNumber |    1234567890 |
    And I enter the details as
      | Fields                    | Value    |
      | ContactPerson_PhoneNumber | 33333333 |
    Then I click on button "OrgDetailsNextBt"
    Then I see text "Invalid Phone Number. Phone Number should be 10 digits. Please try again." displayed
    And I enter the details as
      | Fields                    | Value      |
      | ContactPerson_PhoneNumber | 3333333333 |
    Then I click on button "OrgDetailsNextBt"
    Then I click on button "select2-chosen"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search |  6940 |
    Then I click on button "select2-results"
    #
    #Then I click on "Tax Registration Update"
    Then I click on "Tax Registration Update"
    Then I click on "Update Contact Details"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    And I enter the details as
      | Fields                    | Value      |
      | ContactPerson_PhoneNumber | 3333333333 |
    Then I check "ContactPerson_PhoneNumber" contents match regex "\d\d \d\d\d\d \d\d\d\d"
    #Then I click on button with value "Next"
    #Then I check I am on "Update Contact Details Summary" page
    #Then I click on button with value "Back"
    And I enter the details as
      | Fields                    | Value |
      | ContactPerson_PhoneNumber |    33 |
    Then I click on button with value "Next"
    Then I see text "Invalid Phone Number. Phone should have length 10 and should contain only digits." displayed
    Then I click on "User Profile"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Then I click on button with value "Edit User Profile"
    And I enter the details as
      | Fields      | Value    |
      | PhoneNumber | 04567897 |
    Then I click on button with value "Submit"
    Then I check I am on "Edit User Profile" page
    # Then I see text "Invalid Phone Number. Phone Number should be 10 digits. Please try again." displayed
    And I enter the details as
      | Fields      | Value      |
      | PhoneNumber | 0456789767 |
    Then I click on button with value "Submit"
    Then I check I am on "View User Profile" page

    #Scenarios 3 and 4 are best done manuallyS
    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |

  @review
  Scenario Outline: DTSP-647: Update Payroll Tax Registration form for ease of use
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    #Scenario 3:The User should not see any Title field on the Payroll Tax Registration Form
    Then I click on "Payroll Tax Registration"
    Then I wait for "5000" millisecond
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    And I enter the details as
      | Fields                    | Value      |
      | ContactPerson_PhoneNumber | 3333333333 |
    Then I check "ContactPerson_PhoneNumber" contents match regex "\d\d \d\d\d\d \d\d\d\d"
    Then I enter the details as
      | Fields                    | Value         |
      | AddressLine1              | TEST          |
      | Address_City              | TEST          |
      | ContactPerson_FirstName   | TEST          |
      | ContactPerson_LastName    | TEST          |
      | ContactPerson_Email       | TEST@TEST.com |
      | PostCode                  |          3333 |
      | ContactPerson_PhoneNumber |    1234567890 |
    #Then I select "AL" from "Address_State"
    Then I click on button "AddressLine1"
    # Then I see text "Title" not displayed
    Then I click on button "OrgDetailsNextBt"
    #Scenario 1:User should see 4 digit codes after industry name (retrieved from PSRM) under the Business Activity Category dropdown
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search |  4400 |
    Then I click on button "select2-results-1"
    #Then I see text "Accomodation" displayed
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search |  6932 |
    Then I click on button "select2-results-1"
    # Then I see text "Accounting Services" displayed
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search |  6940 |
    Then I click on button "select2-results-1"
    # Then I see text "Advertising Services" displayed
    Then I click on button "ACTWagesPaidNext"
    #Scenario 2: User should only see 2 options "Yes" or "No" in the radio buttons for the question “Are you a member of a group?”
    Then I click on button "GroupMember_YES"
    Then I click on button "GroupMember_NO"
    #Scenario 5: "Provide Group Number" field should be options
    Then I click on button "GroupMember_YES"
    Then I see text "Provide group number" displayed
    #Scenario 4: The User should not see any Title field on the Update Contact Person Form
    Then I click on "Tax Registration Update"
    Then I click on "Update Contact Details"
    Then I see text "Title" not displayed

    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |

  Scenario Outline: DTSP-649: Add Validation Rules and make other changes to the Payroll Tax Lodgement Form
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return Lodgements"
    Then I click on "Payroll Tax"
    Then I click on button "Discard"
    #Scenario 1: Australia-wide Wages incl. ACT >= ACT Taxable Wages
    #Scenario 4: Days where you paid or were liable to pay taxable or interstate <= no. of days in that particular filing period
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value        |
      | s2id_autogen1_search | QUICK SINGLE |
    Then I click on button "select2-results-1"
    Then I click on "Annual Reconciliation"
    Then I select "2016" from "AnnualObligationSelect"
    Then I click on button with value "Save and Next"
    Then I click on button "ClaimingACTProportion_Yes"
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
      | AustralianWide                                 |     999 |
      | DaysPaidTaxable                                |     367 |
    Then I click on button "SubmitBT"
    Then I see text "Your Aus wide group wages (including ACT) must be equal to or greater than your ACT wages." displayed
    Then I see text "Days where you paid or were liable to pay taxable or interstate should be less than or equal to the number of days in that particular filing period." shown
    Then I click on "Payroll Tax"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Then I click on button "Discard"
    #Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    #Scenario 2: Group ACT Wages >= ACT Taxable Wages
    #Scenario 3: Australia-wide Group Wages incl. ACT >= Group ACT Wages
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value        |
      | s2id_autogen1_search | QUICK SINGLE |
    Then I click on button "select2-results-1"
    Then I click on "Monthly Return"
    Then I select "2017" from "MonthlyObligationSelect"
    Then I click on button with value "Save and Next"
    Then I click on button "ClaimingACTProportion_Yes"
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
      | GroupActWages                                  |      10 |
      | AustralianWide                                 |     999 |
    Then I click on button "SubmitBT"
    Then I see text "Group ACT wages must be equal to or greater than ACT taxable wages or ACT joint taxable wages and equal to or less than Australia-wide wages." displayed
    #		Then I click on "Payroll Tax Lodgement"
    #		Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    #		Then I click on button "Discard"
    #Scenario 5: Days where 1 group member paid or was liable to pay taxable or interstate <= no. of days in that particular filing period
    Then I click on "Payroll Tax"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Then I click on button "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value        |
      | s2id_autogen1_search | QUICK SINGLE |
    Then I click on button "select2-results-1"
    Then I click on "Annual Reconciliation"
    Then I select "2015" from "AnnualObligationSelect"
    Then I click on button with value "Save and Next"
    Then I click on button "ClaimingACTProportion_Yes"
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
      | AustralianWide                                 |     999 |
      | GroupActWages                                  |      10 |
      | DaysPaidTaxable                                |     999 |
    Then I click on button "SubmitBT"
    Then I see text "Days where 1 group member paid or was liable to pay taxable or interstate should be less than or equal to the number of days in that particular filing period." shown
    #Scenario 6: Hints to remind users of the max. no. of days in that filing period
    Then I see text "Max days" displayed
    #Scenario 7: Accordion header and layout of the "Wages / Reconciliation" section
    Then I check object with xpath "//*[contains(@id, 'Titlewages')]//div[3]" contents match regex "\(\d{2} \w+ \d{4} - \d{2} \w+ \d{4} / [\w|\s|\W|\(|\)]+\)"
    #Scenario 9: "Monthly Return" and "Annual Reconciliation" section
    Then I see text "Monthly Return" not displayed
    Then I see text "Annual Reconciliation" not displayed
    #Scenario 8: "Total Amount" section
    Then I enter the details as
      | Fields          | Value    |
      | AustralianWide  | 10000000 |
      | GroupActWages   | 10000000 |
      | DaysPaidTaxable |      150 |
    Then I click on button "SubmitBT"
    Then I see text "Less Total Tax Paid" not displayed

    Examples: 
      | PortalName | UserName | Password   | UserName2 |
      | TSSAdmin   | jbradley | Dbresults1 | jscott    |

  Scenario Outline: DTSP-676:  As a Payroll Tax Group Member, I want to be able to add/edit/remove 'Non-ACT Group Members' to my group
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Group Management"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value        |
      | s2id_autogen1_search | QUICK SINGLE |
    Then I click on button "select2-results-1"
    Then I wait for "4000" millisecond
    Then I click on button with value "Create Group"
    Then I wait for "4000" millisecond
    Then I switch to frame "1"
    Then I select "Group Member" from "GroupRoleComboBox"
    Then I select "Common Control" from "GroupReasonComboBox"
    Then I click on button with value "SAVE"
    Then I check "AddNonActPopUp" exists
    #Scenario 2: Display "Add Non-ACT Group Member" button
    Then I click on "Group Management"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    Then I wait for "4000" millisecond
    Then I click on button with value "Update Group"
    Then I check "AddNonActPopUp" exists
    #Scenario 3: Pop up
    Then I click on button "AddNonActPopUp"
    Then I wait for "4000" millisecond
    Then I switch to frame "1"
    Then I check "OverseasRadioButtonYES" exists
    Then I check "OverseasRadioButtonNO" exists
    Then I check "RegisteredName" exists
    Then I check "OverseasRegNumber" exists
    Then I check "CountryComboBox" exists
    Then I check "GrpMember_ABN" exists
    Then I check "GrpMember_State" exists
    #Scenario 4: Save button activated
    Then I click on button "OverseasRadioButtonYES"
    Then I enter the details as
      | Fields            | Value        |
      | RegisteredName    | TEST NON ACT |
      | OverseasRegNumber |    234234234 |
    Then I select "Lebanon" from "CountryComboBox"
    Then I check "PopUpSaveBT" is not readonly
    Then I click on button "PopUpSaveBT"

    #Scenarios 5, 6 and 7 are best tested manually
    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  @onhold
  Scenario Outline: DTSP-682: Update Country field in Pay Roll Tax Registration form
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Tax Registration Update"
    Then I click on "Update Business Address"
    #Scenario 2: Update Business Address Form
    Then I check "CountryCode" is readonly
    Then I check "CountryCode" contains "AUS"
    Then I click on button "Address_State"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                     |
      | item2 | Australian Capital Territory |
      | item3 | New South Wales              |
      | item4 | Northern Territory           |
      | item5 | Queensland                   |
      | item6 | South Australia              |
      | item7 | Tasmania                     |
      | item7 | Victoria                     |
      | item7 | Western Australia            |
    #Scenario 3: Update Contact Person Form
    Then I click on "Update Contact Details"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    Then I check "CountryId4" contains "AUS"
    Then I click on button "Address_State"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                     |
      | item2 | Australian Capital Territory |
      | item3 | New South Wales              |
      | item4 | Northern Territory           |
      | item5 | Queensland                   |
      | item6 | South Australia              |
      | item7 | Tasmania                     |
      | item7 | Victoria                     |
      | item7 | Western Australia            |
    Then I select "Aruba" from "CountryId"
    Then I see text "Postcode" not displayed
    Then I see text "Territory" not displayed
    Then I see text "Suburb" not displayed
    #Scenario 1: Payroll Tax Registration Form
    Then I click on "Payroll Tax Registration"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    Then I check "CountryCode" is readonly
    Then I check "CountryCode" contains "AUS"
    Then I click on button "CheckBusinessAdress"
    Then I check "CountryCode2" contains "AUS"
    Then I click on button "Address_State2"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                     |
      | item2 | Australian Capital Territory |
      | item3 | New South Wales              |
      | item4 | Northern Territory           |
      | item5 | Queensland                   |
      | item6 | South Australia              |
      | item7 | Tasmania                     |
      | item7 | Victoria                     |
      | item7 | Western Australia            |
    Then I click on button "Address_CountryCode2"
    Then I click on "Aruba"
    # Then I select "Aruba" from "CountryCode2"
    Then I check "Address_City2" does not exist
    Then I check "Address_PostCode2" does not exist
    Then I check "Address_State2" does not exist
    Then I click on button "CheckSameAsJurisdiction"
    Then I check "CountryCode3" contains "AUS"
    Then I click on button "Address_State3"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                     |
      | item2 | Australian Capital Territory |
      | item3 | New South Wales              |
      | item4 | Northern Territory           |
      | item5 | Queensland                   |
      | item6 | South Australia              |
      | item7 | Tasmania                     |
      | item7 | Victoria                     |
      | item7 | Western Australia            |
    Then I click on button "CountryCode3"
    Then I click on "Aruba"
    Then I check "Address_City3" does not exist
    Then I check "Address_PostCode3" does not exist
    Then I check "Address_State3" does not exist

    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |

  @review
  Scenario Outline: DTSP-758: As an end user, I want to be limited to only a month and year selection when I am creating/editing my Payroll Tax Group
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Group Management"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    Then I click on button with value "Update Group"
    #Scenario 1
    Then I click on button "YearCombo"
    Then I see text "2012" displayed
    Then I see text "2013" displayed
    Then I see text "2014" displayed
    Then I see text "2015" displayed
    Then I see text "2016" displayed
    Then I see text "2017" displayed
    Then I see text "2018" displayed
    Then I see text "2019" displayed
    #Scenario 2
    Then I click on button "MonthCombo"
    Then I see text "Jan" displayed
    Then I see text "Feb" displayed
    Then I see text "Mar" displayed
    Then I see text "Apr" displayed
    Then I see text "May" displayed
    Then I see text "Jun" displayed
    Then I see text "Jul" displayed
    Then I see text "Aug" displayed
    Then I see text "Sep" displayed
    Then I see text "Oct" displayed
    Then I see text "Nov" displayed
    Then I see text "Dec" displayed

    #Scenario 3
    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  ###########################################################################################################
  #################################### PHASE 1.1 ITERATION 3 ################################################
  ###########################################################################################################
  @review
  Scenario Outline: DTSP-89: As an end user, I want to be able to view my Activity History so that I can track my previous activities
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    #Scenario 1: Left navigation menu item
    Then I see text "Activity History" displayed
    Then I click on "Activity History"
    #Scenario 2: Activity History page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName          |
      | item2 | ACTIVITY DATE     |
      | item3 | ACTIVITY TYPE     |
      | item4 | ABN               |
      | item5 | ORGANISATION NAME |
      | item6 | DESCRIPTION       |
    #Scenario 3: More than 10 activity history
    Then I check "ListNavigation_PageNumber" exists
    Then I click on "Sign Out"
    Given I want to login to portal "<PortalName>"
    #Scenario 4: No Activity History
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | testman1   |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Activity History"
    Then I see text "You do not have any activity history available." displayed

    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  @review
  Scenario Outline: DTSP-108: As an end user, I want to raise a Generic Request so that I don't need to contact customer service.
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Service Requests"
    Then I click on "Generic Request"
    #Scenario 1: Display "Generic Request" Form
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "GenericRequest_CommunicateWith" is readonly
    Then I check "GenericRequest_RequestType" is readonly
    Then I check "GenericRequest_RequestComments" is readonly
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    #Scenario 2: "Request Details" section displayed on the "Generic Request" Form
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "GenericRequest_CommunicateWith" is not readonly
    Then I check "GenericRequest_RequestType" is not readonly
    Then I check "GenericRequest_RequestComments" is not readonly
    #Scenario 4: Does not trigger.
    #Scenario 6: requires manual testing
    #Scenario 3: Request details pass PSRM validation
    Then I select "Requestor" from "GenericRequest_CommunicateWith"
    Then I select "General Enquiry" from "GenericRequest_RequestType"
    Then I enter the details as
      | Fields                         | Value |
      | GenericRequest_RequestComments | TEST  |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I check I am on "Generic Request Summary" page
    Then I click on button with value "Submit"
    Then I wait for "5000" millisecond
    Then I check I am on "Generic Request Confirmation" page
    Then I see text "Your Generic Request has been successfully submitted. An email has been sent to you for your reference." displayed
    Then I see text "To download the details you have submitted, please click the button below." displayed

    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  Scenario Outline: DTSP-574: As an end user I want to be able to see a summary of my payroll tax details on the dashboard so that I know if my information is up-to-date
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I check I am on "Tooltips" page
    Then I see text "Home" displayed
    Then I click on "Home"
    #Scenario 2: Edit Contact Person
    Then I click on button "ContactPerson_Edit"
    Then I check I am on "Update Contact Details" page
    #Scenario 3: Edit Employer Status
    Then I click on "Home"
    Then I click on button "Home_GroupManagement_Edit"
    Then I check I am on "Group Management" page
    #Scenario 4: Edit Mailing Address
    Then I click on "Home"
    Then I click on button "PostalAddress_Edit"
    Then I check I am on "Update Contact Details" page
    #Scenario 5: Update Net Amount Due section
    Then I click on "Home"
    Then I see text "Account Balance" displayed
    Then I check "BalanceContainer" has CSS property "font-size" with value "14.6667px"
    #Scenario 6: Next Payment Due box
    Then I see text "Next Payment Due" not displayed
    # #Scenario 7: 'Transactions History'
    Then I check "MonthlyTable" exists
    Then I check "YearlyTable" exists
    #Scenario 8: Credit payments
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search | NIGHT |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I check object with xpath "//*[contains(@id, 'TableRecords')]//tbody//tr/td[4]/div" contents match regex "\(\$[\d|,|\.|]+\)"

    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  Scenario Outline: DTSP-685: As an end user, I want all pre populated and non editable fields on the portal to be greyed out
    #Scenario 2: All forms
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Service Requests"
    Then I click on "Annual Lodgement Request"
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "YearCombo" is readonly
    Then I check "MonthCombo" is readonly
    Then I click on "Payroll Tax Exemption Request"
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "ExemptionStartDateInput" is readonly
    Then I check "ExemptionEndDateInput" is readonly
    Then I check "JustificationInput" is readonly
    Then I click on "Liquidation Advice"
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "FirstName" is readonly
    Then I check "LastName" is readonly
    Then I check "PhoneNumber" is readonly
    Then I check "ContactPerson_Email" is readonly
    Then I check "Address_AddressLine" is readonly
    Then I check "CountryId4" is readonly
    #Then I check "Address_State4" is readonly
    Then I click on "Generic Request"
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "GenericRequest_CommunicateWith" is readonly
    Then I check "GenericRequest_RequestType" is readonly
    Then I check "GenericRequest_RequestComments" is readonly
    Then I click on "Objection Request"
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "Objection_Comments" is readonly
    Then I check "ObjectionOutOfTimeYES" is readonly
    Then I check "ObjectionOutOfTimeNO" is readonly
    Then I check "CheckTaxAmount" is readonly
    Then I check "CheckPenalty" is readonly
    Then I check "CheckInterest" is readonly
    Then I check "CheckDecision" is readonly
    Then I click on "Tax Registration Cancellation"
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "CancellationStartDate" is readonly
    Then I check "ReasonDescription" is readonly
    Then I click on "Tax Registration Update"
    Then I click on "Update Business Address"
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "Address_CountryCode" is readonly
    Then I check "Address_AddressLine" is readonly
    Then I check "Address_City" is readonly
    Then I check "Address_State" is readonly
    Then I check "Address_PostCode" is readonly
    Then I click on "Update Business Trading Name"
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "BusinessTradingName" is readonly
    Then I click on "Update Contact Details"
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "ContactPerson_FirstName" is readonly
    Then I check "ContactPerson_LastName" is readonly
    Then I check "ContactPerson_PhoneNumber" is readonly
    Then I check "ContactPerson_Email" is readonly
    Then I check "Address_AddressLine7" is readonly
    #Then I check "Address_City4" is readonly
    #Then I check "Address_PostCode4" is readonly
    Then I click on "Update Refund Details"
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "Refunds_YES" is readonly
    Then I check "Refunds_NO" is readonly
    Then I click on "Return Lodgements"
    Then I click on "Payroll Tax"
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "LodgePayrollAnswer_TypeMonthly" is readonly
    #Then I check "MonthlyObligationSelect" is readonly
    Then I check "LodgePayrollAnswer_TypeAnnual" is readonly

    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  Scenario Outline: DTSP-689: As a user I want to update the order of menu items on the left navigation panel
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                 |
      #| item2 | Home                               |
      | item3 | Lodgements               |
      | item4 | Return History           |
      | item5 | Service Requests         |
      | item6 | Group Management         |
      | item6 | Payroll Tax Registration |
      | item6 | Tax Registration Update  |
      | item6 | Manage Tax Agent         |
      | item6 | Activity History         |
      | item6 | User Profile             |
      | item6 | Sign Out                 |
    Then I click on "Service Requests"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                      |
      | item2 | Annual Lodgement Request      |
      | item3 | Payroll Tax Exemption Request |
      | item4 | Generic Request               |
      | item5 | Liquidation Advice            |
      | item6 | Objection Request             |
      | item6 | Tax Registration Cancellation |
      | item6 | Update Liability Date Request |
    Then I click on "Tax Registration Update"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                     |
      | item2 | Update Business Address      |
      | item3 | Update Business Trading Name |
      | item4 | Update Contact Details       |
      | item5 | Update Refund Details        |
    Then I click on "Return Lodgements"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                           |
      | item2 | Payroll Tax                        |
      | item3 | Utilities (Network Facilities) Tax |
      | item4 | Ambulance Levy                     |
      | item5 | Energy Industry Levy               |

    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  @review
  Scenario Outline: DTSP-690: As an end user, I want to be able to update my Business Trading Name on my Tax Registration so that I can keep my Tax Registration information up-to-date
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Tax Registration Update"
    Then I click on "Update Business Trading Name"
    #Scenario 1: Display "Update Business Trading Name" Form
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                         |
      | item2 | Choose a Taxpayer                |
      | item3 | Organisation Name                |
      | item4 | Australian Business Number (ABN) |
      | item5 | Client Reference Number (CRN)    |
      | item5 | Business Trading Name            |
      | item5 | Request Details                  |
      | item5 | Taxpayer Details                 |
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "BusinessTradingName" is readonly
    #Scenario 2: Business Trading Name section displayed on the "Update Business Trading Name" Form
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search | Aqua  |
    Then I click on button "select2-results-1"
    Then I check "OrganizationalName" is readonly
    Then I check "PayrollAnswer_ABN" is readonly
    Then I check "PayrollAnswer_CRN" is readonly
    Then I check "BusinessTradingName" is not readonly
    #Scenario 3: "Update Business Trading Name" Summary page
    Then I click on button with value "Next"
    Then I see text "Update Business Trading Name Summary" displayed
    #Scenario 5: Update Business Trading Name Submission
    Then I click on button "CorrectInfoDeclared"
    Then I click on button with value "Submit"
    Then I wait for "5000" millisecond
    Then I check I am on "Update Complete" page
    Then I see text "Your Update Business Trading Name Request has been successfully submitted. An email has been sent to you for your reference." displayed
    Then I see text "To download the details you have submitted, please click the button below." displayed

    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  Scenario Outline: DTSP-692: As an end user, I want to see an updated version of the Return History page, so that it is more user-friendly
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    #Scenario 1: Left Navigation Menu
    Then I see text "Return History" displayed
    Then I click on "Return History"
    #Scenario 2: Return History page
    Then I see text "Monthly Return History" displayed
    Then I see text "Annual Return History" displayed
    #Scenario 3: Payment Details
    Then I click on "DETAILS"
    Then I switch to frame "0"
    Then I see text "Payment cannot be made directly through the Self-Serve portal. Please use the details below to make payment through your financial institution." displayed
    Then I see text "Amount" displayed
    Then I see text "Due Date" displayed
    Then I see text "Biller Code" displayed
    Then I see text "Reference Number" displayed

    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  @ignore_until_fixed
  Scenario Outline: DTSP-702: Check if a Taxpayer has already registered for other tax types at Payroll Tax Registration
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Payroll Tax Registration"
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Government" from "SelectBusinessTypeCode"
    #Then I check "RegistrationAnswer_ACN" is empty
    Then I click on button "TaxPayerDetailsNextBT"
    #Scenario 1: Registration form layout changes
    Then I check "EmployerName" is readonly
    Then I check "BusinessTradingName" is readonly
    Then I check "AddressLine1" is readonly
    Then I check "Address_City" is readonly
    Then I check "ContactPerson_FirstName" is readonly
    Then I check "ContactPerson_LastName" is readonly
    Then I check "ContactPerson_Email" is readonly
    Then I check "RegistrationAnswer_ACN" is readonly
    Then I check "PostCode" is readonly
    Then I check "ContactPerson_PhoneNumber" is readonly
    Then I check "SelectBusinessTypeCode" is readonly
    Then I check "Address_CountryCode" is readonly
    Then I check "Address_State" is readonly
    Then I check "CheckBusinessAdress" is readonly
    Then I check "CheckSameAsJurisdiction" is readonly
    Then I check "ContactPerson_PostalAddressId" is readonly
    # Then I check "ContactPerson_CommunicationMethodId" is readonly
    Then I click on "Payroll Tax Registration"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    #Scenario 3: User already registered for Payroll tax
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 13058370433 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I see text "This ABN is already registered for Payroll Tax" shown
    #Scenario 4: User has not registered for any tax
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 32421342134 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Government" from "SelectBusinessTypeCode"
    #Then I check "RegistrationAnswer_ACN" is empty
    Then I click on button "TaxPayerDetailsNextBT"
    Then I see text "Your ABN is not valid. Please enter a valid ABN." displayed

    #Bugged...?
    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |

  Scenario Outline: DTSP-712: To update all wording on the portal from "Tax Payer" to the single word "Taxpayer"
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return Lodgements"
    Then I click on "Payroll Tax"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Utilities (Network Facilities) Tax"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Ambulance Levy"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Energy Industry Levy"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Service Requests"
    Then I click on "Annual Lodgement Request"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Payroll Tax Exemption Request"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Generic Request"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Liquidation Advice"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Objection Request"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Tax Registration Cancellation"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Group Management"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Payroll Tax Registration"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Tax Registration Update"
    Then I click on "Update Business Address"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Update Business Trading Name"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Update Contact Details"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Update Refund Details"
    Then I see text "Taxpayer" displayed
    Then I see text "Tax Payer" not displayed
    Then I click on "Sign Out"

    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  @review
  Scenario Outline: DTSP-703: As an user, I want to fill in a declaration section when I fill in an Objection Request, so that I can verify that I have submitted this request
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Service Requests"
    Then I click on "Objection Request"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    #Scenario 3: "Objection Request" Summary page
    Then I click on button "ObjectionOutOfTimeYES"
    Then I enter the details as
      | Fields             | Value     |
      | Objection_Comments | DESIGNATE |
      | LodgeFailureReason | DESIGNATE |
    Then I click on button "CheckPenalty"
    Then I click on button with value "Next"
    Then I check I am on "Objection Request Summary" page
    #Scenario 1:
    Then I check "DeclarationData" exists
    #Scenario 2: Submit button
    Then I click on button "CorrectInfoDeclared"
    Then I check "SummarySubmitBT" is not readonly
    #Scenario 3: Confirmation page
    Then I click on button "SummarySubmitBT"
    Then I check I am on "Objection Request Confirmation" page

    Examples: 
      | PortalName | UserName | Password   |
      | TSSAdmin   | jbradley | Dbresults1 |

  Scenario Outline: DTSP-770: To update the information sent to PSRM in the declaration section
    #Scenario 1: Declaration on Summary Page of all forms
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return Lodgements"
    Then I click on "Payroll Tax"
    And I check I am on "Payroll Lodgement Form" page
    Then I click on button "Discard"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I click on "Monthly Return"
    Then I select "Aug 2016" from "MonthlyObligationSelect"
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
    Then I click on button with value "Next"
    Then I click on button with value "Next"
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
      | Fields               | Value |
      | s2id_autogen1_search | AQUA  |
    Then I click on button "select2-results-1"
    Then I click on button "CancellationStartDate"
    Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
    Then I enter the details as
      | Fields            | Value |
      | ReasonDescription | TEST  |
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
      | Fields               | Value               |
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
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "	DESIGNATE PTY. LTD."
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
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation         | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | QUICK SINGLE PTY LTD | 04 5678 9767 | katherine.santos@dbresults.com.au |

  Scenario Outline: DTSP-779: To update the Payroll Tax Registration Form to remove the autopopulated declaration section
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Payroll Tax Registration"
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I check label "Label_EmployerName" contains "Organisation Name"
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    #Then I select "Mr" from "ContactPerson_Title"
    #  Then I select "Direct Post" from "CommunicationMethodId"
    Then I enter the details as
      | Fields                    | Value         |
      | AddressLine1              | TEST          |
      | Address_City              | TEST          |
      | ContactPerson_FirstName   | TEST          |
      | ContactPerson_LastName    | TEST          |
      | ContactPerson_Email       | TEST@TEST.com |
      | PostCode                  |          3333 |
      | ContactPerson_PhoneNumber |    1234567890 |
    Then I click on button "OrgDetailsNextBt"
    Then I check "ContactPerson_PhoneNumber" contents match regex "\d\d \d\d\d\d \d\d\d\d"
    Then I wait for "5000" millisecond
    Then I check "ACTWagesPaidNextBt" is readonly
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value        |
      | s2id_autogen1_search | Turf Growing |
    Then I click on button "select2-results-1"
    Then I click on button "ACTWagesPaidNextBt"
    Then I check "PayrollNext" is readonly
    Then I enter the details as
      | Fields            | Value |
      | NumberOfEmployees |    33 |
      | NumberOfEmployees |    33 |
    Then I click on button "DateBusinessStart"
    Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
    #	Then I enter the details as
    #  | DateBusinessStart  | 12032033 |
    Then I click on button "DateBusinessLiable"
    Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
    Then I click on button "PayrollNextBT"
    Then I click on button "Refunds_NO"
    Then I click on button "RefundDetailsBT"
    Then I check "Declarer_FirstName" exists
    Then I check "Declarer_LastName" exists
    Then I check "Declarer_Organisation" exists
    Then I check "Declarer_Position" exists
    Then I check "Declarer_PhoneNumber" exists
    Then I check "Declarer_Email" exists

    #Scenarios 2-5 should be done manually
    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |

  @manual
  Scenario Outline: As an end user I want to see the Industry codes before Industry name in the Business Activity Category Drop down on Payroll Tax registration form
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Payroll Tax Registration"
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I check label "Label_EmployerName" contains "Organisation Name"
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    #Then I select "Mr" from "ContactPerson_Title"
    # Then I select "Direct Post" from "CommunicationMethodId"
    Then I enter the details as
      | Fields                    | Value         |
      | AddressLine1              | TEST          |
      | Address_City              | TEST          |
      | ContactPerson_FirstName   | TEST          |
      | ContactPerson_LastName    | TEST          |
      | ContactPerson_Email       | TEST@TEST.com |
      | PostCode                  |          3333 |
      | ContactPerson_PhoneNumber |    1234567890 |
    Then I click on button "OrgDetailsNextBt"
    Then I wait for "5000" millisecond
    Then I check "ACTWagesPaidNextBt" is readonly
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value        |
      | s2id_autogen1_search | Turf Growing |
    Then I click on button "select2-results-1"
    Then I check "select2-chosen-1" contents match regex "\d\d\d\d .*"

    #maybe this should be done manually...
    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |

  ###########################################################################################################
  #################################### PHASE 1.2 ITERATION 1.2 ################################################
  ###########################################################################################################
  @review
  Scenario Outline: DTSP-33: As an end user, I want to be able to submit an Ambulance Levy Lodgement Form so that I can validate in PSRM
    #Scenario 1: Ambulance Levy  Lodgement
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return Lodgements"
    Then I see text "Payroll Tax" displayed
    Then I see text "Ambulance Levy" displayed
    Then I click on "Ambulance Levy"
    Then I check I am on "Ambulance Levy Lodgement Form" page
    Then I click on button "GeneralDiscardBt"
    Then I check "SelectTaxPayer" exists
    Then I check "LodgePayrollAnswer_OrganizationalName" exists
    Then I check "LodgePayrollAnswer_ABN" exists
    Then I check "LodgePayrollAnswer_CRN" exists
    Then I check "ObligationsDropdown" exists
    #Scenario 2: Selected ABN is not registered for "Ambulance Levy "
    Then I click on button "GeneralDiscardBt"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value               |
      | s2id_autogen1_search | <WrongOrganisation> |
    Then I click on button "select2-results-1"
    Then I see text "You are currently not registered for Ambulance Levy" displayed
    Then I check "ObligationsDropdown" is readonly
    #Scenario 3: Selected ABN is registered for "Ambulance Levy"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value                 |
      | s2id_autogen1_search | <CorrectOrganisation> |
    Then I click on button "select2-results-1"
    Then I check "ObligationsDropdown" is not readonly
    Then I select "2014" from "ObligationsDropdown"
    #Scenario 4: Buttons
    Then I click on button "SaveNextBT"
    Then I check "SaveAndNextToSummaryBT" is readonly
    #Scenario 5: PSRM validation
    Then I enter the details as
      | Fields                                       | Value |
      | LodgeAmbulanceLevyAnswer_NumberSingleMembers |    11 |
      | LodgeAmbulanceLevyAnswer_NumberFamilyMembers |    11 |
    Then I check "SaveAndNextToSummaryBT" is not readonly
    Then I click on button "SaveAndNextToSummaryBT"
    Then I check I am on "Lodgement Summary" page

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | WrongOrganisation | CorrectOrganisation | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | AQUA PTY LTD      | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  Scenario Outline: DTSP-34: As an end user, I want to be able to submit a Energy Industry Levy Return form so that I can validate in PSRM
    #Scenario 1: Ambulance Levy  Lodgement
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return Lodgements"
    Then I see text "Payroll Tax" displayed
    Then I see text "Energy Industry Levy" displayed
    Then I click on "Energy Industry Levy"
    Then I check I am on "Energy Industry Levy Lodgement Form" page
    Then I click on button "GeneralDiscardBt"
    Then I check "SelectTaxPayer" exists
    Then I check "LodgePayrollAnswer_OrganizationalName" exists
    Then I check "LodgePayrollAnswer_ABN" exists
    Then I check "LodgePayrollAnswer_CRN" exists
    Then I check "ObligationsDropdown" exists
    #Scenario 2: Selected ABN is not registered for "Ambulance Levy "
    Then I click on button "GeneralDiscardBt"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value               |
      | s2id_autogen1_search | <WrongOrganisation> |
    Then I click on button "select2-results-1"
    Then I see text "You are currently not registered for the Energy Industry Levy" displayed
    Then I check "ObligationsDropdown" is readonly
    #Scenario 3: Selected ABN is registered for "Ambulance Levy"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value                 |
      | s2id_autogen1_search | <CorrectOrganisation> |
    Then I click on button "select2-results-1"
    Then I check "ObligationsDropdown" is not readonly
    Then I select "2014" from "ObligationsDropdown"
    #Scenario 4: Buttons
    Then I click on button "SaveNextBT"
    Then I check "RemoveBTN" is readonly
    Then I check "AddBTN" is readonly
    Then I check "SaveAndNextToSummaryBT" is readonly
    #Scenario 5: PSRM validation
    Then I select "Electricity Distribution Sector" from "SupplyDistributionSector_SectorType"
    Then I enter the details as
      | Fields                                             | Value |
      | SupplyDistributionSector_EstimateMegawattHours     |    50 |
      | SupplyDistributionSector_ActualMegawattHours       |    50 |
      | SupplyDistributionSector_MethodCalculateTotalMegaw | TeST  |
    Then I check "SaveAndNextToSummaryBT" is not readonly
    Then I check "AddBTN" is not readonly
    Then I check "RemoveBTN" is readonly
    Then I click on button "AddBTN"
    Then I click on button "AddBTN"
    Then I check "RemoveBTN" is readonly
    Then I select "Electricity Supply Sector" from "SupplyDistributionSector_SectorType"
    Then I enter the details as
      | Fields                                             | Value |
      | SupplyDistributionSector_EstimateMegawattHours     |    50 |
      | SupplyDistributionSector_ActualMegawattHours       |    50 |
      | SupplyDistributionSector_MethodCalculateTotalMegaw | TeST  |
    Then I check "SaveAndNextToSummaryBT" is not readonly
    Then I click on button "SaveAndNextToSummaryBT"
    Then I check I am on "Lodgement Summary" page

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | WrongOrganisation | CorrectOrganisation      | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | AQUA PTY LTD      | MEMBER CHECK PTY LIMITED | 04 5678 9767 | katherine.santos@dbresults.com.au |

  Scenario Outline: DTSP-38: As an end user, I want to be able to complete a Utilities(Network Facilities) Tax Return Form so that I can validate it in PSRM
    #Scenario 1: Ambulance Levy  Lodgement
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return Lodgements"
    Then I see text "Payroll Tax" displayed
    Then I see text "Utilities (Network Facilities) Tax" displayed
    Then I click on "Utilities (Network Facilities) Tax"
    Then I check I am on "Network Utilities Lodgement Form" page
    Then I click on button "GeneralDiscardBt"
    Then I check "SelectTaxPayer" exists
    Then I check "LodgePayrollAnswer_OrganizationalName" exists
    Then I check "LodgePayrollAnswer_ABN" exists
    Then I check "LodgePayrollAnswer_CRN" exists
    Then I check "ObligationsDropdown" exists
    #Scenario 2: Selected ABN is not registered for "Ambulance Levy "
    Then I click on button "GeneralDiscardBt"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value               |
      | s2id_autogen1_search | <WrongOrganisation> |
    Then I click on button "select2-results-1"
    Then I see text "You are currently not registered for Utilities(Network Facilities) Tax" displayed
    Then I check "ObligationsDropdown" is readonly
    #Scenario 3: Selected ABN is registered for "Ambulance Levy"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value                 |
      | s2id_autogen1_search | <CorrectOrganisation> |
    Then I click on button "select2-results-1"
    Then I check "ObligationsDropdown" is not readonly
    Then I select "2015" from "ObligationsDropdown"
    #Scenario 4: Buttons
    Then I click on button "SaveNextBT"
    Then I check "RemoveBTN" is readonly
    Then I check "AddBTN" is readonly
    Then I check "SaveAndNextToSummaryBT" is readonly
    #Scenario 5: PSRM validation
    Then I select "Water Network" from "NetworkDetail_UtilityTypeDropdown"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields          | Value |
      | KMOfRouteLength |    50 |
    Then I check "SaveAndNextToSummaryBT" is not readonly
    Then I check "AddBTN" is not readonly
    Then I check "RemoveBTN" is readonly
    Then I click on button "AddBTN"
    Then I click on button "AddBTN"
    Then I check "RemoveBTN" is readonly
    Then I select "Sewerage Network" from "NetworkDetail_UtilityTypeDropdown"
    Then I enter the details as
      | Fields          | Value |
      | KMOfRouteLength |    50 |
    Then I check "SaveAndNextToSummaryBT" is not readonly
    Then I click on button "SaveAndNextToSummaryBT"
    Then I check I am on "Lodgement Summary" page

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | WrongOrganisation | CorrectOrganisation      | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | AQUA PTY LTD      | MEMBER CHECK PTY LIMITED | 04 5678 9767 | katherine.santos@dbresults.com.au |

  @review
  Scenario Outline: DTSP-151: As an end user, I want to be able to view my Return History for Network Utilities Tax Type
    #Scenario 1: Selecting relevant tab
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return History"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I click on "Utilities (Network Facilities)"
    Then I wait for "5000" millisecond
    Then I see text "RETURN PERIOD" displayed
    Then I see text "PAYMENT DUE DATE" displayed
    Then I see text "TAX PAYABLE" displayed
    Then I see text "INTEREST" displayed
    Then I see text "PENALTY" displayed
    Then I see text "PAID AMOUNT" displayed
    Then I see text "BALANCE" displayed
    Then I see text "PAYMENT" displayed
    Then I see text "SUBMIT" displayed
    #Scenario 2: PAYMENT DETAILS link
    Then I click on "DETAILS"
    Then I switch to frame "0"
    Then I click on button with value "CANCEL"

    Examples: 
      | PortalName | UserName | Password | FirstName | LastName | Position | Organisation | ContactPhone | EmailAddress |

  Scenario Outline: DTSP-154: As an end user, I want to be able to navigate to different Tax type return history pages using tabs
    #Scenario 1: Scenario 1: Order of Tax type Tabs
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return History"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I check object with xpath "//*[contains(@id, 'TSSAccountMgmtCore_wtTaxTypesTabBar')]//*[contains(@id, 'TSSAccountMgmtCore_wtTaxTypesTabBar')]" contains "PAYROLL"
    Then I check object with xpath "//div[contains(@id, 'TSSAccountMgmtCore_wtTaxTypesTabBar')][2]" contains "UTILITIES (NETWORK FACILITIES)"
    Then I check object with xpath "//*[contains(@id, 'TSSAccountMgmtCore_wtTaxTypesTabBar')]//*[contains(@id, 'TSSAccountMgmtCore_wtTaxTypesTabBar')][3]" contains "AMBULANCE LEVY"
    Then I check object with xpath "//*[contains(@id, 'TSSAccountMgmtCore_wtTaxTypesTabBar')]//*[contains(@id, 'TSSAccountMgmtCore_wtTaxTypesTabBar')][4]" contains "ENERGY INDUSTRY LEVY"
    Then I check object with xpath "//*[contains(@id, 'TSSAccountMgmtCore_wtTaxTypesTabBar')]//*[contains(@id, 'TSSAccountMgmtCore_wtTaxTypesTabBar')][5]" contains "INCOME TAX EQUIVALENT"
    Then I click on "PAYROLL"
    Then I wait for "5000" millisecond
    Then I see text "RETURN PERIOD" displayed
    Then I see text "PAYMENT DUE DATE" displayed
    Then I see text "TAX PAYABLE" displayed
    Then I see text "INTEREST" displayed
    Then I see text "PENALTY" displayed
    Then I see text "PAID AMOUNT" displayed
    Then I see text "BALANCE" displayed
    Then I see text "PAYMENT" displayed
    Then I see text "SUBMIT" displayed
    Then I click on "UTILITIES (NETWORK FACILITIES)"
    Then I click on object with xpath "//div[contains(@id, 'TSSAccountMgmtCore_wtTaxTypesTabBar')]//a[contains(text(), 'AMBULANCE LEVY')]"
    Then I click on object with xpath "//div[contains(@id, 'TSSAccountMgmtCore_wtTaxTypesTabBar')]//a[contains(text(), 'AMBULANCE LEVY')]"
    Then I click on "INCOME TAX EQUIVALENT"
    #Then I click on button "select2-chosen-1"
    #Then I enter the details as
    #| Fields               | Value      |
    #| s2id_autogen1_search | BLATCHFORD |
    #Then I click on button "select2-results-1"
    #Then I see text "This ABN is currently not registered for any tax types." displayed
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value  |
      | s2id_autogen1_search | SUBMIT |
    Then I click on button "select2-results-1"
    Then I see text "UTILITIES (NETWORK FACILITIES)" not displayed
    Then I see text "AMBULANCE LEVY" not displayed
    Then I see text "ENERGY INDUSTRY LEVY" not displayed
    Then I see text "INCOME TAX EQUIVALENT" not displayed
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value    |
      | s2id_autogen1_search | Late Cut |
    Then I click on button "select2-results-1"
    Then I check object with xpath "//div[contains(@id, 'TSSAccountMgmtCore_wtTaxTypesTabBar')]//div[contains(@id, 'TSSAccountMgmtCore_wtTaxTypesTabBar')][2]" contains "UTILITIES (NETWORK FACILITIES)"

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  Scenario Outline: DTSP-742: As an end user I want to be able to update Objection Request Form to cater for different Tax Types
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Service Requests"
    #Scenario 1: Portal Navigation
    Then I see text "Objection Request" displayed
    Then I click on "Objection Request"
    Then I check "SelectTaxPayer" exists
    Then I check "LodgePayrollAnswer_OrganizationalName" exists
    Then I check "LodgePayrollAnswer_ABN" exists
    Then I check "LodgePayrollAnswer_CRN" exists
    #Then I click on button "GeneralDiscardBt"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I click on button "TaxTypeSelection"
    Then I see text "Ambulance Levy" displayed
    Then I see text "Energy Industry Levy" displayed
    Then I see text "Income Tax Equivalent" displayed
    Then I see text "Payroll Tax" displayed
    Then I see text "Utilities(Network Facilities) Tax" displayed
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value                |
      | s2id_autogen1_search | ABCAD DESIGN PTY LTD |
    Then I click on button "select2-results-1"
    Then I check "TaxTypeSelection" is readonly
    Then I check "TaxTypeSelection" contains "PAYROLL"
    Then I click on "Objection Request"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I click on button "TaxTypeSelection"
    Then I click on "Utilities(Network Facilities) Tax"
    Then I click on button "ObjectionOutOfTimeYES"
    Then I enter the details as
      | Fields             | Value                  |
      | Objection_Comments | ObjectionComment       |
      | LodgeFailureReason | LodgementFailureReason |
    Then I click on button "CheckPenalty"
    Then I click on button with value "Next"
    Then I check I am on "Objection Request Summary" page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                                          |
      | item2 | Organisation Name                                 |
      | item3 | Australian Business Number (ABN)                  |
      | item4 | Client Reference Number (CRN)                     |
      | item5 | Subject of Objection                              |
      | item6 | Is the Objection out of time                      |
      | item7 | Reason for failing to lodge the objection on time |
      | item7 | Comments                                          |
    Then I check object with xpath "//*[contains(@id, 'ObjectionInformation')]//..//tr[3]//td[2]" contains "Yes"
    Then I check object with xpath "//*[contains(text(), 'Tax Type')]/following-sibling::td" contains "Utilities (Network Facilities) Tax"
    Then I check object with xpath "//*[contains(text(), 'Subject of Objection')]/..//following-sibling::td" contains "Penalty"
    Then I check object with xpath "//*[contains(text(), 'Reason for failing to lodge the objection on time')]/..//following-sibling::td" contains "LodgementFailureReason"
    Then I check object with xpath "//*[contains(text(), 'Comments')]/..//following-sibling::td" contains "ObjectionComment"
    #check declaration
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  #@dolater
  #Scenario Outline: DTSP-743: As an end user I want to be able to update Exemption Request Form to cater for different Tax Types
  #Given I want to login to portal "<PortalName>"
  #And I enter the details as
  #| Fields        | Value      |
  #| UserNameInput | <UserName> |
  #| PasswordInput | <Password> |
  #And I hit Enter
  #Then I click on "Service Requests"
  #Then I click on "Payroll Tax Exemption Request"
  #Scenario 1: Display "Objection Request" Form
  #Then I check "OrganizationalName" is readonly
  #Then I check "PayrollAnswer_ABN" is readonly
  #Then I check "PayrollAnswer_CRN" is readonly
  #Then I check "ExemptionStartDateInput" is readonly
  #Then I check "ExemptionEndDateInput" is readonly
  #Then I check "JustificationInput" is readonly
  #Scenario 2: "Objection Information" section displayed on the "Objection Request" Form
  #Then I click on button "select2-chosen-1"
  #Then I enter the details as
  #| Fields               | Value          |
  #| s2id_autogen1_search | <Organisation> |
  #Then I click on button "select2-results-1"
  #Then I click on button "TaxTypeSelection"
  #Then I see text "Ambulance Levy" displayed
  #Then I see text "Energy Industry Levy" displayed
  #Then I see text "Income Tax Equivalent" displayed
  #Then I see text "Payroll Tax" displayed
  #Then I see text "Utilities(Network Facilities) Tax" displayed
  #Then I click on button "select2-chosen-1"
  #Then I enter the details as
  #| Fields               | Value  |
  #| s2id_autogen1_search | Abacus |
  #Then I click on button "select2-results-1"
  #Then I check "TaxTypeSelection" is readonly
  #Then I check "TaxTypeSelection" contains "PAYROLL"
  #Then I click on "Payroll Tax Exemption Request"
  #Then I click on button "select2-chosen-1"
  #Then I enter the details as
  #| Fields               | Value          |
  #| s2id_autogen1_search | <Organisation> |
  #Then I click on button "select2-results-1"
  #Then I enter the details as
  #| Fields                  | Value  |
  #| ExemptionStartDateInput | 020617 |
  #| ExemptionEndDateInput   | 030617 |
  #		Then I click on button "ExemptionStartDateInput"
  #Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
  #	Then I enter the details as
  #  | DateBusinessStart  | 12032033 |
  #Then I click on button "ExemptionEndDateInput"
  #Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
  #Then I enter the details as
  #| Fields             | Value |
  #| JustificationInput | TEST  |
  #
  #Examples:
  #| PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
  #| TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |
  Scenario Outline: DTSP-745: As an end user I want to be able to update Tax Registration Cancellation Form to cater for registration cancellation of different Tax Types
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Service Requests"
    Then I click on "Tax Registration Cancellation"
    #Scenario 1: Display "Objection Request" Form
    Then I check "OrganizationalName" is empty
    Then I check "PayrollAnswer_ABN" is empty
    Then I check "PayrollAnswer_CRN" is empty
    Then I check "CancellationStartDate" is readonly
    #Scenario 2: "Objection Information" section displayed on the "Objection Request" Form
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    Then I click on button "TaxTypeSelection"
    Then I see text "Ambulance Levy" displayed
    Then I see text "Energy Industry Levy" displayed
    Then I see text "Income Tax Equivalent" displayed
    Then I see text "Payroll Tax" displayed
    Then I see text "Utilities(Network Facilities) Tax" displayed
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value    |
      | s2id_autogen1_search | Good Inc |
    Then I click on button "select2-results-1"
    Then I check "TaxTypeSelection" is readonly
    Then I check "TaxTypeSelection" contains "PAYROLL"
    Then I click on "Tax Registration Cancellation"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    #Then I select "Utilities(Network Facilities) Tax" from "TaxTypeSelection"
    #		Then I see text "Ambulance Levy" displayed
    #		Then I see text "Energy Industry Levy" displayed
    #		Then I see text "Income Tax Equivalent" displayed
    #		Then I see text "Payroll Tax" displayed
    #		Then I see text "Utilities(Network Facilities) Tax" displayed
    Then I click on button "CancellationStartDate"
    Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
    #	Then I enter the details as
    #  | DateBusinessStart  | 12032033 |
    #		Then I click on button "CancellationStartDate"
    #Then I click on "20170603"
    Then I enter the details as
      | Fields            | Value |
      | ReasonDescription | TEST  |
    Then I click on button with value "Next"
    Then I check I am on "Tax Cancellation Request Summary" page
    #Then I check object with xpath "//*[contains(text(), 'Cancellation Effective Date')]/..//following-sibling::td" contains "02 Jun 2017"
    #Then I check object with xpath "//*[contains(text(), 'Requested Exemption End Date')]/..//following-sibling::td" contains "03 Jun 2017"
    Then I check object with xpath "//*[contains(text(), 'Tax Type')]//following-sibling::td" contains "Payroll Tax"
    Then I check object with xpath "//*[contains(text(), 'Reason Description')]/..//following-sibling::td" contains "TEST"
    #check declaration
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | AQUA PTY LTD | 04 5678 9767 | katherine.santos@dbresults.com.au |

  Scenario Outline: DTSP-788: As an end user, I want to be able to complete a Utilities(Network Facilities) Tax Return Form so that I can validate it in PSRM
    #Scenario 1: Ambulance Levy  Lodgement
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return Lodgements"
    Then I see text "Payroll Tax" displayed
    Then I see text "Utilities (Network Facilities) Tax" displayed
    Then I click on "Utilities (Network Facilities) Tax"
    Then I check I am on "Network Utilities Lodgement Form" page
    Then I click on button "GeneralDiscardBt"
    Then I check "SelectTaxPayer" exists
    Then I check "LodgePayrollAnswer_OrganizationalName" exists
    Then I check "LodgePayrollAnswer_ABN" exists
    Then I check "LodgePayrollAnswer_CRN" exists
    Then I check "ObligationsDropdown" exists
    #Scenario 2: Selected ABN is not registered for "Ambulance Levy "
    Then I click on button "GeneralDiscardBt"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value               |
      | s2id_autogen1_search | <WrongOrganisation> |
    Then I click on button "select2-results-1"
    Then I see text "You are currently not registered for Utilities(Network Facilities) Tax" displayed
    Then I check "ObligationsDropdown" is readonly
    #Scenario 3: Selected ABN is registered for "Ambulance Levy"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value                 |
      | s2id_autogen1_search | <CorrectOrganisation> |
    Then I click on button "select2-results-1"
    Then I check "ObligationsDropdown" is not readonly
    Then I select "2015" from "ObligationsDropdown"
    #Scenario 4: Buttons
    Then I click on button "SaveNextBT"
    Then I check "RemoveBTN" is readonly
    Then I check "AddBTN" is readonly
    Then I check "SaveAndNextToSummaryBT" is readonly
    #Scenario 5: PSRM validation
    Then I select "Gas Distribution Network" from "NetworkDetail_UtilityTypeDropdown"
    Then I enter the details as
      | Fields          | Value |
      | KMOfRouteLength |    50 |
    #| SupplyDistributionSector_ActualMegawattHours       |    50 |
    #| SupplyDistributionSector_MethodCalculateTotalMegaw | TeST  |
    Then I check "SaveAndNextToSummaryBT" is not readonly
    Then I check "AddBTN" is not readonly
    Then I check "RemoveBTN" is readonly
    Then I click on button "AddBTN"
    Then I click on button "SaveAndNextToSummaryBT"
    Then I check I am on "Lodgement Summary" page
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<CorrectOrganisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    Then I check object with xpath "//*[contains(text(), 'Utility Type')]//following-sibling::td" contains "Gas Distribution Network"
    Then I check object with xpath "//*[contains(text(), 'Kilometres of Route Length')]//following-sibling::td" contains "50.00 KM"
    Then I check object with xpath "//*[contains(text(), 'Rate Per Kilometre')]//following-sibling::td" contains "$992.00 /KM"
    Then I check object with xpath "//*[contains(text(), 'Tax Payable')]//following-sibling::td" contains "$49,600.00"
    Then I check object with xpath "//*[contains(text(), 'Total Amount Payable')]/..//following-sibling::td//div" contains "$49,600.00"
    Then I check object with xpath "//*[contains(text(), 'Organisation Name')]/..//following-sibling::td" contains "<CorrectOrganisation>"
    Then I check object with xpath "//*[contains(text(), 'Australian Business Number (ABN)')]/..//following-sibling::td" contains "64129012344"
    Then I check object with xpath "//*[contains(text(), 'Client Reference Number (CRN)')]/..//following-sibling::td" contains "400109"
    Then I check object with xpath "//*[contains(text(), 'Return Period')]//following-sibling::td" contains "01 Apr 2014 - 31 Mar 2015"
    Then I click on button with value "Back"
    Then I check I am on "Network Utilities Lodgement Form" page
    # Then I click on button "SaveNextBT"
    Then I click on button "SaveAndNextToSummaryBT"
    #Then I check "SaveAndNextToSummaryBT" is readonly
    Then I check I am on "Lodgement Summary" page
    Then I click on button "CorrectInfoDeclared"
    Then I check "SummarySubmitBT" is not readonly

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | WrongOrganisation | CorrectOrganisation      | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | AQUA PTY LTD      | MEMBER CHECK PTY LIMITED | 04 5678 9767 | katherine.santos@dbresults.com.au |

  @review
  Scenario Outline: DTSP-792: As an end user, I want to be able to view the Ambulance Levy lodgement summary page
    #Scenario 1: Ambulance Levy  Lodgement
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return Lodgements"
    Then I see text "Payroll Tax" displayed
    Then I see text "Ambulance Levy" displayed
    Then I click on "Ambulance Levy"
    Then I check I am on "Ambulance Levy Lodgement Form" page
    Then I click on button "GeneralDiscardBt"
    Then I check "SelectTaxPayer" exists
    Then I check "LodgePayrollAnswer_OrganizationalName" exists
    Then I check "LodgePayrollAnswer_ABN" exists
    Then I check "LodgePayrollAnswer_CRN" exists
    Then I check "ObligationsDropdown" exists
    #Scenario 2: Selected ABN is not registered for "Ambulance Levy "
    Then I click on button "GeneralDiscardBt"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I check "ObligationsDropdown" is not readonly
    Then I select "2014" from "ObligationsDropdown"
    #Scenario 4: Buttons
    Then I click on button "SaveNextBT"
    Then I wait for "5000" millisecond
    Then I check "SaveAndNextToSummaryBT" is readonly
    #Scenario 5: PSRM validation
    Then I enter the details as
      | Fields                                       | Value |
      | LodgeAmbulanceLevyAnswer_NumberSingleMembers |    11 |
      | LodgeAmbulanceLevyAnswer_NumberFamilyMembers |    11 |
    Then I check "SaveAndNextToSummaryBT" is not readonly
    Then I click on button "SaveAndNextToSummaryBT"
    Then I check I am on "Lodgement Summary" page
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    Then I check object with xpath "//*[contains(text(), 'Number of Single Members')]/..//following-sibling::td//div" contains "11"
    Then I check object with xpath "//*[contains(text(), 'Single Member Rate Per Week')]/..//following-sibling::td//div" contains "$2.20"
    Then I check object with xpath "//*[contains(text(), 'Amount Payable Per Week (Single Member)')]/..//following-sibling::td//div" contains "$24.20"
    Then I check object with xpath "//*[contains(text(), 'Number of Family Members')]/..//following-sibling::td//div" contains "11"
    Then I check object with xpath "//*[contains(text(), 'Family Members Rate Per Week')]/..//following-sibling::td//div" contains "$4.40"
    Then I check object with xpath "//*[contains(text(), 'Amount Payable Per Week (Family Members)')]/..//following-sibling::td//div" contains "$48.40"
    Then I check object with xpath "//*[contains(text(), 'Total Amount Payable (Weekly)')]/..//following-sibling::td//div" contains "$72.60"
    Then I check object with xpath "//*[contains(text(), 'Total Amount Payable')]/..//following-sibling::td//div" contains "$72.60"
    Then I check object with xpath "//*[contains(text(), 'Organisation Name')]/..//following-sibling::td" contains "DESIGNATE PTY. LTD."
    Then I check object with xpath "//*[contains(text(), 'Australian Business Number (ABN)')]/..//following-sibling::td" contains "85085664197"
    Then I check object with xpath "//*[contains(text(), 'Client Reference Number (CRN)')]/..//following-sibling::td" contains "400107"
    Then I check object with xpath "//*[contains(text(), 'Return Date')]//following-sibling::td" contains "Jun 2014"
    Then I check object with xpath "//*[contains(text(), 'Reference Period')]//following-sibling::td" contains "Mar 2014"
    Then I click on button with value "Back"
    Then I check I am on "Ambulance Levy Lodgement Form" page
    # Then I click on button with value "
    Then I click on button "SaveAndNextToSummaryBT"
    #Then I check "SaveAndNextToSummaryBT" is readonly
    Then I check I am on "Lodgement Summary" page
    Then I click on button "CorrectInfoDeclared"
    Then I check "SummarySubmitBT" is not readonly

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  Scenario Outline: DTSP-796: As an end user, I want to be able to view the Energy Industry Levy lodgement summary page with all calculated fields for Energy Industry Levy
    #Scenario 1: Ambulance Levy  Lodgement
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return Lodgements"
    Then I see text "Payroll Tax" displayed
    Then I see text "Energy Industry Levy" displayed
    Then I click on "Energy Industry Levy"
    Then I click on button "GeneralDiscardBt"
    Then I check I am on "Energy Industry Levy Lodgement Form" page
    Then I check "SelectTaxPayer" exists
    Then I check "LodgePayrollAnswer_OrganizationalName" exists
    Then I check "LodgePayrollAnswer_ABN" exists
    Then I check "LodgePayrollAnswer_CRN" exists
    Then I check "ObligationsDropdown" exists
    #Scenario 2: Selected ABN is not registered for "Ambulance Levy "
    Then I click on button "GeneralDiscardBt"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value               |
      | s2id_autogen1_search | <WrongOrganisation> |
    Then I click on button "select2-results-1"
    Then I see text "You are currently not registered for the Energy Industry Levy" displayed
    Then I check "ObligationsDropdown" is readonly
    #Scenario 3: Selected ABN is registered for "Ambulance Levy"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I check "ObligationsDropdown" is not readonly
    Then I select "2017" from "ObligationsDropdown"
    #Scenario 4: Buttons
    Then I click on button "SaveNextBT"
    Then I check "RemoveBTN" is readonly
    Then I check "AddBTN" is readonly
    Then I check "SaveAndNextToSummaryBT" is readonly
    #Scenario 5: PSRM validation
    Then I select "Electricity Distribution Sector" from "SupplyDistributionSector_SectorType"
    Then I enter the details as
      | Fields                                             | Value |
      | SupplyDistributionSector_EstimateMegawattHours     |    50 |
      | SupplyDistributionSector_ActualMegawattHours       |    50 |
      | SupplyDistributionSector_MethodCalculateTotalMegaw | TeST  |
    Then I check "SaveAndNextToSummaryBT" is not readonly
    Then I check "AddBTN" is not readonly
    Then I check "RemoveBTN" is readonly
    Then I click on button "AddBTN"
    Then I click on button "AddBTN"
    Then I check "RemoveBTN" is readonly
    Then I select "Electricity Supply Sector" from "SupplyDistributionSector_SectorType"
    Then I enter the details as
      | Fields                                             | Value |
      | SupplyDistributionSector_EstimateMegawattHours     |    50 |
      | SupplyDistributionSector_ActualMegawattHours       |    50 |
      | SupplyDistributionSector_MethodCalculateTotalMegaw | TeST  |
    Then I check "SaveAndNextToSummaryBT" is not readonly
    Then I click on button "SaveAndNextToSummaryBT"
    Then I check I am on "Lodgement Summary" page
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
    Then I check object with xpath "//*[contains(text(), 'Sector Type')]/..//following-sibling::td//div" contains "Electricity Supply Sector"
    #Then I check object with xpath "//*[contains(text(), 'Return Period')]/..//following-sibling::td//div" contains "01 Jul 2013 - 30/06/2014"
    Then I check object with xpath "//*[contains(text(), 'Total Amount Payable')]/..//following-sibling::td//div" contains "$10,046.69"
    Then I check object with xpath "//*[contains(text(), 'Estimate Megawatt Hours')]/..//following-sibling::td//div" contains "50"
    Then I check object with xpath "//*[contains(text(), 'Actual Megawatt Hours')]/..//following-sibling::td//div" contains "50"
    Then I check object with xpath "//*[contains(text(), 'Method used to Calculate Total Megawatt Hours')]/..//following-sibling::td//div" contains "TeST"

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | WrongOrganisation | Organisation             | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | AQUA PTY LTD      | MEMBER CHECK PTY LIMITED | 04 5678 9767 | katherine.santos@dbresults.com.au |

  Scenario Outline: DTSP-836: As an end user, I want to be required to select a JRL if I have group members that are not lodging itselfs
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Group Management"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on button with value "Update Group"
    #Scenario 1: Group members without a JRL
    #Click on ticked box
    Then I click on button "CheckboxDGE"
    Then I select "2018" from "YearCombo"
    Then I select "Jan" from "MonthCombo"
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I see text "You must nominate a group member as a DGE and/or JRL if you have any group members with a Group Role as 'Group Member'" displayed
    Then I click on "Group Management"
    #Scenario 2: DGE is the only ACT Group Member in a 'Group Member' Group Role
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on button with value "Update Group"
    Then I click on button "CheckboxJRL"
    Then I select "2018" from "YearCombo"
    Then I select "Jan" from "MonthCombo"
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I check I am on "Payroll Tax Group Update Summary" page

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  #@dolater
  #Scenario Outline: DTSP-837: As a an end user creating/updating a group, I want to see a more detailed error message when I am prevented from adding a particular group member
  #Given I want to login to portal "<PortalName>"
  #And I enter the details as
  #| Fields        | Value      |
  #| UserNameInput | <UserName> |
  #| PasswordInput | <Password> |
  #And I hit Enter
  #Then I click on "Group Management"
  #Then I click on button "select2-chosen-1"
  #Then I enter the details as
  #| Fields               | Value          |
  #| s2id_autogen1_search | <Organisation> |
  #Then I click on button "select2-results-1"
  #Then I wait for "5000" millisecond
  #Scenario 1: Not valid in PSRM
  #Then I click on button with value "Update Group"
  #Then I click on button with value "Add Act Group Member"
  #Then I wait for "5000" millisecond
  #Then I switch to frame "0"
  #Then I click on button "GroupRoleComboBox"
  #Then I click on "Group Member"
  #Then I select "Common Control" from "GroupReasonComboBox"
  #And I enter the details as
  #| Fields        | Value      |
  #| GrpMember_ABN | 1231231231 |
  #Then I click on button "PopUpSaveBT"
  #Then I see text "Please enter an ABN that is registered for Payroll Tax" displayed
  #Scenario 2: In another group
  #Then I wait for "5000" millisecond
  #Then I click on button with value "Add Act Group Member"
  #Then I wait for "5000" millisecond
  #Then I switch to frame "0"
  #Then I select "Group Member" from "GroupRoleComboBox"
  #Then I click on button "GroupRoleComboBox"
  #Then I click on "Group Member"
  #Then I select "Common Control" from "GroupReasonComboBox"
  #And I enter the details as
  #| Fields        | Value       |
  #| GrpMember_ABN | 25612700008 |
  #Then I click on button "PopUpSaveBT"
  #Then I see text "Please enter an ABN that is not already part of a Payroll Tax Group." displayed
  #Scenario 3: Adding a Non-ACT Group Member
  #Then I click on button "AddNonActPopUp"
  #Then I wait for "5000" millisecond
  #Then I switch to frame "0"
  #Then I enter the details as
  #| Fields                     | Value        |
  #| wtGrpMember_RegisteredName | TEST NON ACT |
  #| GrpMember_ABN              |    234234234 |
  #Then I select "Victoria" from "GrpMember_State"
  #Then I check "PopUpSaveBT" is not readonly
  #Then I click on button "PopUpSaveBT"
  #Then I see text "Please enter a valid ABN" displayed
  #
  #Examples:
  #| PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
  #| TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | MEMBER CHECK PTY LIMITED | 04 5678 9767 | katherine.santos@dbresults.com.au |
  @review
  Scenario Outline: DTSP-838: As an end user, I want to see instructions when I am submitting an Annual Lodgement request
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Service Requests"
    #Scenario 1: Portal Navigation
    Then I click on "Annual Lodgement Request"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I see text "Your annual tax liability must be $6,000 or less to be eligible for annual lodgement." displayed

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  @current
  Scenario Outline: DTSP-840: As a user I want to add Non-ACT members in my group using Radio buttons for overseas members
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Group Management"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on button with value "Update Group"
    #Scenario 1: Pop up
    Then I wait for "5000" millisecond
    Then I click on button "AddNonActPopUp"
    Then I wait for "5000" millisecond
    Then I switch to frame "1"
    Then I click on button "OverseasRadioButtonYES"
    Then I enter the details as
      | Fields            | Value        |
      | RegisteredName    | TEST NON ACT |
      | OverseasRegNumber |    234234234 |
    Then I select "Lebanon" from "CountryComboBox"
    Then I check "PopUpSaveBT" is not readonly
    Then I click on button "PopUpSaveBT"
    #Scenario 2: NON-ACT Group member Table
    Then I check object with xpath "//*[contains(@id, 'TableNonACTMembers')]//td[3]" contains "TEST NON ACT"
    Then I check object with xpath "//*[contains(@id, 'TableNonACTMembers')]//td[4]" contains "234234234"
    Then I check object with xpath "//*[contains(@id, 'TableNonACTMembers')]//td[6]" contains "Lebanon"
    #Scenario 3: Summary page
    Then I click on button "CheckboxJRL"
    Then I select "2018" from "YearCombo"
    Then I select "Jan" from "MonthCombo"
    Then I click on button with value "Next"
    Then I wait for "2400" millisecond
    Then I check I am on "Payroll Tax Group Update Summary" page
    Then I check object with xpath "//*[contains(@id, 'NewNonACTGrpMembersDiv')]//tr//td" contains "Overseas Member"
    Then I check object with xpath "//*[contains(@id, 'NewNonACTGrpMembersDiv')]//tr//td[2]" contains "Yes"
    Then I check object with xpath "//*[contains(@id, 'NewNonACTGrpMembersDiv')]//tr[2]//td" contains "Registered Name"
    Then I check object with xpath "//*[contains(@id, 'NewNonACTGrpMembersDiv')]//tr[2]//td[2]" contains "TEST NON ACT"
    Then I check object with xpath "//*[contains(@id, 'NewNonACTGrpMembersDiv')]//tr[3]//td" contains "Overseas Member Registration Number"
    Then I check object with xpath "//*[contains(@id, 'NewNonACTGrpMembersDiv')]//tr[3]//td[2]" contains "234234234"
    Then I check object with xpath "//*[contains(@id, 'NewNonACTGrpMembersDiv')]//tr[5]//td" contains "Country"
    Then I check object with xpath "//*[contains(@id, 'NewNonACTGrpMembersDiv')]//tr[5]//td[2]" contains "Lebanon"

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  @review
  Scenario Outline: DTSP-850: As an end user, I want to update the Payroll Tax Registration form, so that it is easier to use
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Payroll Tax Registration"
    #Scenario 1: Registered for tax other than payroll
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 17118795716 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I see text "You are already registered for another tax type, please provide your Customer Reference Number (CRN) below to continue registering for Payroll Tax" displayed
    Then I check "RegistrationAnswer_CRN" exists
    Then I check "SelectBusinessTypeCode" does not exist
    Then I check "RegistrationAnswer_BusinessTradingName" does not exist
    Then I check "RegistrationAnswer_ACN" does not exist
    Then I click on button with value "Discard"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    #Scenario 2: ABN not registered in PSRM
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 12332451324 |
    Then I click on button with value "Next"
    Then I check "SelectBusinessTypeCode" exists
    Then I check "RegistrationAnswer_BusinessTradingName" exists
    Then I check "RegistrationAnswer_ACN" exists
    #Scenario 3: ABR validation
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I enter the details as
      | Fields                                 | Value |
      | EmployerName                           | TEST  |
      | RegistrationAnswer_BusinessTradingName | TEST  |
    Then I click on button "TaxPayerDetailsNextBT"
    Then I see text "Your ABN is not valid. Please enter a valid ABN." displayed
    #Scenario 4: Successful ABR Validation
    Then I click on "Payroll Tax Registration"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    And I wait for "5000" millisecond
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I check label "Label_EmployerName" contains "Organisation Name"
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    #Then I select "Mr" from "ContactPerson_Title"
    #Then I select "Direct Post" from "CommunicationMethodId"
    Then I enter the details as
      | Fields                    | Value         |
      | AddressLine1              | TEST          |
      | Address_City              | TEST          |
      | ContactPerson_FirstName   | TEST          |
      | ContactPerson_LastName    | TEST          |
      | ContactPerson_Email       | TEST@TEST.com |
      | PostCode                  |          3333 |
      | ContactPerson_PhoneNumber |    1234567890 |
    Then I click on button "OrgDetailsNextBt"

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      | CompanyName          |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au | Dynamic Fire Pty Ltd |

  @review
  Scenario Outline: DTSP-899: As an end user I want to see the "Activity Type" drop down on activity history updated to cater for all Tax types
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Activity History"
    Then I click on button "ActivityType"
    Then I see text "Activity Type" displayed
    Then I select "Group Management Update" from "ActivityType"
    Then I select "Lodgement & Amendment" from "ActivityType"
    Then I select "Tax Registration Update" from "ActivityType"
    Then I select "Service Request" from "ActivityType"

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      | CompanyName          |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au | Dynamic Fire Pty Ltd |

  #@dolater
  #Scenario Outline: DTSP-705: As an end user, I want to be able to raise aUpdate Liability Date Request on the portal so that I can disclose any changes in date for my tax registration for a chosen tax type
  #Given I want to login to portal "<PortalName>"
  #And I enter the details as
  #| Fields        | Value      |
  #| UserNameInput | <UserName> |
  #| PasswordInput | <Password> |
  #And I hit Enter
  #Scenario 1: Display "Voluntary Disclosure Request" Form
  #Then I click on "Service Requests"
  #Then I see text "Update Liability Date Request" displayed
  #Then I click on "Update Liability Date Request"
  #Then I check "SelectTaxPayer" exists
  #Then I check "LodgePayrollAnswer_OrganizationalName" is readonly
  #Then I check "LodgePayrollAnswer_ABN" is readonly
  #Then I check "LodgePayrollAnswer_CRN" is readonly
  #Scenario 2: "Voluntary Disclosure Request" section displayed on the "Voluntary Disclosure Request" Form
  #Then I click on button "select2-chosen-1"
  #Then I enter the details as
  #| Fields               | Value          |
  #| s2id_autogen1_search | <Organisation> |
  #Then I click on button "select2-results-1"
  #Then I check "NextBT" is readonly
  #Then I click on button "TaxTypeSelection"
  #Then I see text "Ambulance Levy" displayed
  #Then I see text "Energy Industry Levy" displayed
  #Then I see text "Income Tax Equivalent" displayed
  #Then I see text "Payroll Tax" displayed
  #Then I select "Payroll Tax" from "TaxTypeSelection"
  #Scenario 3: Request details pass PSRM validation
  #Then I enter the details as
  #| Fields              | Value  |
  #| DisclosureDateInput | 090916 |
  #Then I click on button "DisclosureDateInput"
  #Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
  #Then I check "NextBT" is not readonly
  #Then I click on button "NextBT"
  #Then I see text "For tax type PAYROLL disclosure form is not valid because there is a tax role 6800964293 starting at 2013-05-01 which is prior to the disclosure date." displayed
  #		Then I click on button "DisclosureDateInput"
  #Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
  #Then I click on button "NextBT"
  #Then I check I am on "Update Liability Date Request Summary" page
  #check declaration
  #Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
  #Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
  #Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
  #Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
  #Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
  #Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"
  #Then I check object with xpath "//*[contains(text(), 'Organisation Name')]/..//following-sibling::td" contains "<Organisation>"
  #Then I check object with xpath "//*[contains(text(), 'Australian Business Number (ABN)')]/..//following-sibling::td" contains "85085664197"
  #Then I check object with xpath "//*[contains(text(), 'Client Reference Number (CRN)')]/..//following-sibling::td" contains "400107"
  #Then I check object with xpath "//*[contains(text(), 'Liability Commencement Date')]//following-sibling::td" contains "01 May 2013"
  #Then I check object with xpath "//*[contains(text(), 'Tax Type')]//following-sibling::td" contains "Payroll Tax"
  #Then I click on button "CorrectInfoDeclared"
  #Then I check "SummarySubmitBT" is not readonly
  #Then I click on button with value "Back"
  #Then I click on button with value "Cancel"
  #Then I check I am on "Home" page
  #
  #Examples:
  #| PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
  #| TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |
  #@dolater
  #Scenario Outline: DTSP-706: As an end user, I want to be able to raise a Refund Request on the portal so that I can request a refund for the Carry forward amount to the Tax Office
  #Given I want to login to portal "<PortalName>"
  #And I enter the details as
  #| Fields        | Value      |
  #| UserNameInput | <UserName> |
  #| PasswordInput | <Password> |
  #And I hit Enter
  #Then I click on "Service Requests"
  #Then I see text "Carry Forward Authorization" displayed
  #Then I click on "Carry Forward Authorization"
  #Scenario 1: Selected ABN is not eligible for "Carry Forward Authorization"     Then I check "SelectTaxPayer" exists
  #Then I check "LodgePayrollAnswer_OrganizationalName" is readonly
  #Then I check "LodgePayrollAnswer_ABN" is readonly
  #Then I check "LodgePayrollAnswer_CRN" is readonly
  #Then I click on button "select2-chosen-1"
  #Then I enter the details as
  #| Fields               | Value     |
  #| s2id_autogen1_search | DESIGNATE |
  #Then I click on button "select2-results-1"
  #Then I check "NextBT" is readonly
  #Then I see text "You currently do not have any obligations with credit balance." displayed
  #Then I check "LodgePayrollAnswer_OrganizationalName" is readonly
  #Then I check "LodgePayrollAnswer_ABN" is readonly
  #Then I check "LodgePayrollAnswer_CRN" is readonly
  #Scenario 2: Selected ABN is eligible for "Carry Forward Authorization"
  #Then I click on button "select2-chosen-1"
  #Then I enter the details as
  #| Fields               | Value            |
  #| s2id_autogen1_search | Late Cut Pty Ltd |
  #Then I click on button "select2-results-1"
  #Then I check "LodgePayrollAnswer_OrganizationalName" contains "Late Cut Pty Ltd"
  #Then I check "LodgePayrollAnswer_ABN" contains "56114795274"
  #Then I check "LodgePayrollAnswer_CRN" contains "400106"
  #Then I check "RefundRequest_TaxPayerBalance" contains "$ -30,490.83"
  #Then I check "ObligationDescription" contains "Utilities Network Tax,01/07/2015-31/03/2016"
  #Then I check "CreditAmount" contains "$ -30,490.83"
  #Then I enter the details as
  #| Fields             | Value          |
  #| CarryForwardAmount | 23423423423243 |
  #Then I click on button with value "Next"
  #Then I see text "Amount to Carry Forward cannot be greater than Credit Amount" displayed
  #Then I see text "There are outstanding filing/lodgments that the taxpayer is eligible for." displayed
  #
  #Then I click on button "CancelBT"
  #Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
  #Then I check I am on "Home" page
  #
  #Examples:
  #| PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
  #| TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |
  ###########################################################################################################
  #################################### PHASE 1.2 ITERATION 2 ################################################
  ###########################################################################################################
  Scenario Outline: DTSP-746: As an end user I want to be able to update contact details on Tax Registration updates for different tax types
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    #Scenario 1: Accurate labels and text
    Then I click on "Tax Registration Update"
    Then I click on "Update Contact Details"
    Then I check "LodgePayrollAnswer_OrganizationalName" is readonly
    Then I check "LodgePayrollAnswer_ABN" is readonly
    Then I check "LodgePayrollAnswer_CRN" is readonly
    Then I check "TaxTypeSelection" is readonly
    Then I check "ContactPerson_FirstName" is readonly
    Then I check "ContactPerson_LastName" is readonly
    Then I check "ContactPerson_Email" is readonly
    Then I check "Address_CountryId" is readonly
    Then I check "wtAddress_AddressLine" is readonly
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName             |
      | item2 | Tax Type             |
      | item2 | First Name           |
      | item2 | Last Name            |
      | item2 | Contact Phone Number |
      | item2 | Email Address        |
      | item2 | Country              |
      | item2 | Address              |
      | item2 | Contact Person       |
      | item2 | Postal Address       |
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    #Scenario 2: Drop down
    Then I click on button "TaxTypeSelection"
    Then I see text "Utilities (Network Facilities)" not displayed
    Then I see text "Ambulance Levy" not displayed
    Then I see text "Energy Industry Levy" not displayed
    Then I see text "Income Tax Equivalent" not displayed
    Then I see text "Payroll Tax" not displayed
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search | ABCAD |
    Then I click on button "select2-results-1"
    Then I check "TaxTypeSelection" exists
    Then I click on button with value "Next"
    Then I click on button with value "Next"
    Then I wait for "6000" millisecond
    Then I check I am on "Update Contact Details Summary" page
    Then I click on button "CorrectInfoDeclared"
    Then I click on button with value "Submit"
    Then I wait for "5000" millisecond
    Then I check I am on "Update Complete" page

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  Scenario Outline: DTSP-747: As an end user I want to be able to update refund details on Tax Registration updates for different tax types
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    #Scenario 1: Accurate labels and text
    Then I click on "Tax Registration Update"
    Then I click on "Update Refund Details"
    Then I check "LodgePayrollAnswer_OrganizationalName" is readonly
    Then I check "LodgePayrollAnswer_ABN" is readonly
    Then I check "LodgePayrollAnswer_CRN" is readonly
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I click on button "Refunds_YES"
    Then I check "TaxTypeSelection" is readonly
    Then I check "Refunds_YES" is readonly
    Then I check "Refunds_NO" is readonly
    Then I check "RegistrationAnswer_BSB" is readonly
    Then I check "RegistrationAnswer_BankAccountNumber" is readonly
    Then I check "RegistrationAnswer_BankAccountName" is readonly
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                        |
      | item2 | Tax Type                        |
      | item2 | Set up bank account for refunds |
      | item2 | BSB                             |
      | item2 | Bank Account Number             |
      | item2 | Bank Account Name               |
    #| item2 | Country |
    #| item2 | Address |
    #| item2 | Contact Person |
    #| item2 | Postal Address |
    #	Then I click on button "select2-chosen-1"
    #	Then I enter the details as
    #| Fields               | Value |
    #| s2id_autogen1_search | <Organisation> |
    #Then I click on button "select2-results-1"
    #Then I wait for "4000" millisecond
    #Scenario 2: Drop down
    Then I click on button "TaxTypeSelection"
    Then I see text "Utilities (Network Facilities)" not displayed
    Then I see text "Ambulance Levy" not displayed
    Then I see text "Energy Industry Levy" not displayed
    Then I see text "Income Tax Equivalent" not displayed
    Then I see text "Payroll Tax" not displayed
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search | ABCAD |
    Then I click on button "select2-results-1"
    Then I check "TaxTypeSelection" exists
    Then I click on button "Refunds_NO"
    Then I click on button with value "Next"
    Then I wait for "6000" millisecond
    Then I check I am on "Update Refund Details Summary" page
    Then I click on button "CorrectInfoDeclared"
    Then I click on button with value "Submit"
    Then I wait for "5000" millisecond
    Then I check I am on "Update Complete" page

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  @current
  Scenario Outline: DTSP-749: As an end user I want to be able to update refund details on Tax Registration updates for different tax types
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Home"
    #Scenario 1: Tabs for Home page
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I check object with xpath "//a[contains(@id, 'TaxTypesTabBar')]" contains "PAYROLL"
    Then I check object with xpath "(//a[contains(@id, 'TaxTypesTabBar')])[2]" contains "UTILITIES (NETWORK FACILITIES)"
    Then I check object with xpath "(//a[contains(@id, 'TaxTypesTabBar')])[3]" contains "AMBULANCE LEVY"
    Then I check object with xpath "(//a[contains(@id, 'TaxTypesTabBar')])[4]" contains "ENERGY INDUSTRY LEVY"
    Then I check object with xpath "(//a[contains(@id, 'TaxTypesTabBar')])[5]" contains "INCOME TAX EQUIVALENT"
    #Scenario 3: User views ' Tax Details' Box
    Then I check "PayrollTaxDetailsWebblock_block" exists
    Then I check object with xpath "(//div[contains(@id, 'AccountInfo')])[6]" contains "Employer Status"
    Then I check object with xpath "(//div[contains(@id, 'AccountInfo')])[7]" contains "DGE in Group Number: 19"
    Then I check object with xpath "(//div[contains(@id, 'AccountInfo')])[11]" contains "Contact Person"
    Then I check object with xpath "(//div[contains(@id, 'AccountInfo')])[14]" contains "John Smith"
    #Then I check object with xpath "(//div[contains(@id, 'AccountInfo')])[15]" contains "04 1234 5678"
    Then I check object with xpath "(//span[contains(@id, 'AccountInfo')])[6]" contains "Postal Address"
    Then I check object with xpath "//*[contains(@id, 'AccountInfo_wtEmail')]" contains "abc@abc.com"
    Then I check object with xpath "(//div[contains(@id, 'AccountInfo')])[23]" contains "1 Collins Stsadfasdfasdfdsfasfd"
    Then I check object with xpath "(//div[contains(@id, 'AccountInfo')])[24]" contains "Melbourne"
    Then I check object with xpath "(//span[contains(@id, 'AccountInfo')])[8]" contains "Business Trading Name"
    Then I check object with xpath "(//div[contains(@id, 'AccountInfo')])[30]" contains "<Organisation>"
    #Scenario 4: Edit Contact Person
    Then I click on button "ContactPerson_Edit"
    Then I check I am on "Update Contact Details" page
    Then I check "LodgePayrollAnswer_OrganizationalName" contains "<Organisation>"
    Then I check "LodgePayrollAnswer_ABN" contains "<ABN>"
    Then I check "LodgePayrollAnswer_CRN" contains "<CRN>"
    Then I click on "Home"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    #Scenario 5: Edit Postal Address
    Then I click on button "PostalAddress_Edit"
    Then I check I am on "Update Contact Details" page
    Then I check "LodgePayrollAnswer_OrganizationalName" contains "<Organisation>"
    Then I check "LodgePayrollAnswer_ABN" contains "<ABN>"
    Then I check "LodgePayrollAnswer_CRN" contains "<CRN>"
    Then I click on "Home"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    #Scenario 6: Display “Outstanding Lodgements” box
    Then I see text "Your Outstanding Tax Returns to Lodge:" displayed
    #Scenario 7: User clicks on “VIEW HISTORY” button
    Then I click on button with value "View History"
    Then I check I am on "Return History" page
    Then I click on "Home"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    #Scenario 8: User clicks on “LODGE RETURN” button
    Then I click on button with value "Lodge Return"
    Then I check I am on "Payroll Lodgement Form" page
    Then I click on "Home"
    #Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value      |
      | s2id_autogen1_search | BLATCHFORD |
    Then I click on button "select2-results-1"
    #Scenario 10: User not registered for any tax types
    Then I see text "This ABN is currently not registered for any tax types." displayed

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ABN         | CRN    |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 85085664197 | 400107 |

  Scenario Outline: DTSP-814: As an end user, I want to be able to amend my lodged Payroll Tax returns, so that I can fix any mistakes I have made
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return History"
    Then I check I am on "Return History" page
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I click on "AMEND"
    Then I click on button with value "Next"
    Then I click on button "SubmitBT"
    Then I wait for "5000" millisecond
    Then I check I am on "Lodgement Summary" page
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//td[contains(., 'Salaries and Wages')]/following-sibling::td" contains "$324.00"
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//td[contains(., 'Bonuses')]/following-sibling::td" contains "$342.00"
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//td[contains(., 'Commissions')]/following-sibling::td" contains "$342.00"
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//td[contains(., 'Allowances')]/following-sibling::td" contains "$234.00"
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//tr[5]//td[1]" contains "Directors' Fees"
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//tr[5]//td[2]" contains "$34.00"
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//td[contains(., 'Eligible Termination Payments')]/following-sibling::td" contains "$324.00"
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//td[contains(., 'Value of Benefits')]/following-sibling::td" contains "$324.00"
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//td[contains(., 'Share / Options Value')]/following-sibling::td" contains "$234.00"
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//td[contains(., 'Service Contracts')]/following-sibling::td" contains "$234.00"
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//td[contains(., 'Superannuation')]/following-sibling::td" contains "$234.00"
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//td[contains(., 'Other Taxable Payments')]/following-sibling::td" contains "$234.00"
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//td[contains(., 'ACT Joint Taxable Wages')]/following-sibling::td" contains "$2,860.00"
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//td[contains(., 'ACT wages not included on this return')]/following-sibling::td" contains "$234.00"
    Then I check object with xpath "//*[contains(@id, 'ACTWagesPaidorTaxable')]//td[contains(., 'Claiming the ACT proportion of the threshold')]/following-sibling::td" contains "No"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  @review
  Scenario Outline: DTSP-865: As a user I want to see changes made on Payroll tax lodgements, registration page and return history so that its consistent with additional tax types
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    #Scenario 1: Changes to Payroll Return History page
    Then I click on "Return History"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I check "ReturnPeriod2" contents match regex "\w{3} \d{4}"
    #Scenario 2: Changes to Payroll Tax Registration page
    Then I click on "Payroll Tax Registration"
    Then I wait for "5000" millisecond
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    # Then I select "Direct Post" from "CommunicationMethodId"
    Then I enter the details as
      | Fields                    | Value         |
      | AddressLine1              | TEST          |
      | Address_City              | TEST          |
      | ContactPerson_FirstName   | TEST          |
      | ContactPerson_LastName    | TEST          |
      | ContactPerson_Email       | TEST@TEST.com |
      | PostCode                  |          3333 |
      | ContactPerson_PhoneNumber |    1234567890 |
    #Then I select "AL" from "Address_State"
    Then I click on button "AddressLine1"
    # Then I see text "Title" not displayed
    Then I click on button "OrgDetailsNextBt"
    Then I check "ControlAndFinancialInterest_FirstName" exists
    Then I check "ControlAndFinancialInterest_LastName" exists
    Then I check "ControlAndFinancialInterestRelationshipType" exists
    Then I check "GeneralDiscardBt" exists
    Then I check "AddControlFinancialInterestButton" exists
    Then I enter the details as
      | Fields                                | Value |
      | ControlAndFinancialInterest_FirstName | TEST  |
      | ControlAndFinancialInterest_LastName  | TEST  |
    Then I click on button "ControlAndFinancialInterestRelationshipType"
    Then I click on "Director"
    Then I click on button "AddControlFinancialInterestButton"
    Then I check "RemoveControlFinancialInterestList" exists
    #Scenario 3: Changes to Payroll tax lodgement page
    Then I click on "Return Lodgements"
    Then I click on "Payroll Tax"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Then I wait for "5000" millisecond
    Then I click on button "GeneralDiscardBt"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value      |
      | s2id_autogen1_search | BLATCHFORD |
    Then I click on button "select2-results-1"
    Then I see text "You are currently not registered for Payroll Tax" displayed
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value        |
      | s2id_autogen1_search | QUICK SINGLE |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on "Annual Reconciliation"
    Then I select "2016" from "AnnualObligationSelect"
    Then I click on button with value "Save and Next"
    Then I click on button "ClaimingACTProportion_No"
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
    Then I click on button "SubmitBT"
    Then I check I am on "Payroll Tax Lodgement Summary" page

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      | CompanyName          |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au | Dynamic Fire Pty Ltd |

  @review
  Scenario Outline: DTSP-870: As an end user, I want to be able to amend my lodgements for Ambulance Levy, so that I can rectify errors  + DTSP-879: As an end user, I want to see a Summary Page, Confirmation Page, PDF and email notification for an Ambulance Levy Amendment
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return History"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on object with xpath "(//a[contains(@id, 'TaxTypesTabBar')])[3]"
    #Scenario 1: Pre populated fields
    Then I click on "AMEND"
    Then I check I am on "Amend Ambulance Levy Lodgement" page
    Then I check "LodgePayrollAnswer_OrganizationalName" contains "<Organisation>"
    Then I check "LodgePayrollAnswer_ABN" contains "<ABN>"
    Then I check "LodgePayrollAnswer_CRN" contains "<CRN>"
    Then I check object with xpath "//*[contains(@id, 'ObligationToAmend')]" contents match regex "\w{3} \d{4}"
    Then I check object with xpath "//*[contains(@id, 'ReturnDate')]" contents match regex "\w{3} \d{4}"
    Then I click on button with value "Next"
    Then I click on button "SaveAndNextToSummaryBT"
    Then I check I am on "Lodgement Summary" page
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                                 |
      | item2 | Number of Single Members                 |
      | item2 | Single Member Rate Per Week              |
      | item2 | Amount Payable Per Week (Single Member)  |
      | item2 | Number of Family Members                 |
      | item2 | Family Members Rate Per Week             |
      | item2 | Amount Payable Per Week (Family Members) |
      | item2 | Total Amount Payable (Weekly)            |
      | item2 | Total Amount Payable                     |
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      | CompanyName          | ABN         | CRN    |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au | Dynamic Fire Pty Ltd | 85085664197 | 400107 |

  Scenario Outline: DTSP-877: As an end user, I want to be able to amend my lodgements for Utilitites (Network Facilities) Tax, so that I can rectify errors + DTSP-884: As an end user, I want to be able to see the Summary Page, Confirmation Page, PDF, and email notification for Energy Industry Levy Amendments
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return History"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I check object with xpath "(//a[contains(@id, 'TaxTypesTabBar')])[4]" contains "ENERGY INDUSTRY LEVY"
    Then I click on object with xpath "(//a[contains(@id, 'TaxTypesTabBar')])[4]"
    Then I click on "AMEND"
    Then I check I am on "Amend Energy Industry Levy Lodgement" page
    Then I check "LodgePayrollAnswer_OrganizationalName" contains "<Organisation>"
    Then I check "LodgePayrollAnswer_ABN" contains "<ABN>"
    Then I check "LodgePayrollAnswer_CRN" contains "<CRN>"
    Then I check "ObligationToAmend" is not empty
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I check "EstMegawattHrs2" is not empty
    Then I check "ActMegawattHrs2" is not empty
    Then I click on button "SaveAndNextToSummaryBT"
    Then I check I am on "Lodgement Summary" page
    Then I see text "Energy Industry Levy Lodgement Amendment Summary" displayed
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                                                  |
      | item2 | Return Period                                             |
      | item2 | Sector Type                                               |
      | item2 | Estimate Megawatt Hours                                   |
      | item2 | Estimate Fixed Component                                  |
      | item2 | Estimate Variable Component                               |
      | item2 | Estimate Fix Component+(Variable Component*Megawatt Hour) |
      | item2 | Actual Megawatt Hours                                     |
      | item2 | Actual Fixed Component                                    |
      | item2 | Actual Variable Component                                 |
      | item2 | Actual Fix Component+(Variable Component*Megawatt Hour)   |
      | item2 | Levy Payable                                              |
      | item2 | Method used to Calculate Total Megawatt Hours             |
      | item2 | Total Levies Paid                                         |
      | item2 | Total Estimated Amount                                    |
      | item2 | Total Amount Payable                                      |
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[1]//td[2]" contains "<FirstName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[2]//td[2]" contains "<LastName>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[3]//td[2]" contains "<Organisation>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[4]//td[2]" contains "<Position>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[5]//td[2]" contains "<ContactPhone>"
    Then I check object with xpath "//*[contains(@id, 'DeclarationData')]//tr[6]//td[2]" contains "<EmailAddress>"

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      | CompanyName          | ABN         | CRN    |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au | Dynamic Fire Pty Ltd | 85085664197 | 400107 |

  Scenario Outline: DTSP-894: As an end user, I want to limit my options on the Generic Request form in the Request Type Dropdown
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Service Requests"
    Then I click on "Generic Request"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I click on button "GenericRequest_RequestType"
    Then I see text "Compliance tip-off" displayed
    Then I see text "Exemption" displayed
    Then I see text "Payroll Tax Exclusion" displayed
    Then I see text "General Enquiry" displayed
    Then I see text "Variation" displayed
    Then I see text "Freedom of Information" not displayed
    Then I see text "Objection" not displayed
    Then I see text "Ombudsman's Request" not displayed

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  @review
  Scenario Outline: DTSP-895: As an end user, I want to see instructions on the Activity History page, so that I understand how to filter my entries
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Activity History"
    Then I see text "Your lodged service requests and forms are listed here. Use the document link to view your submission." displayed
    Then I see text "Enter one or more of the below filter options to search through your activity history." displayed

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  Scenario Outline: DTSP-920: As an end user, I want to see an updated Return History for all tax types, so that I can select an obligation to amend
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Return History"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName         |
      | item2 | RETURN PERIOD    |
      | item2 | PAYMENT DUE DATE |
      | item2 | TAX PAYABLE      |
      | item2 | INTEREST         |
      | item2 | PENALTY          |
      | item2 | PAID AMOUNT      |
      | item2 | BALANCE          |
      | item2 | PAYMENT          |
      | item2 | SUBMIT           |

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  #@wip
  #Scenario Outline: DTSP-962: As an end user, I want to see an updated portal, so that it is easier for me to use
  #Given I want to login to portal "<PortalName>"
  #And I enter the details as
  #| Fields        | Value      |
  #| UserNameInput | <UserName> |
  #| PasswordInput | <Password> |
  #And I hit Enter
  #Then I click on "Home"
  #Scenario 1: Date formats
  #Then I click on "Service Requests"
  #Then I click on "Tax Registration Cancellation"
  #Then I click on button "select2-chosen-1"
  #Then I enter the details as
  #| Fields               | Value |
  #| s2id_autogen1_search | AQUA  |
  #Then I click on button "select2-results-1"
  #Then I enter the details as
  #| Fields            | Value |
  #| ReasonDescription | TEST  |
  #Then I enter the details as
  #| Fields                | Value      |
  #| CancellationStartDate | 16-06-2017 |
  #Then I click on button with value "Next"
  #Then I see "CancellationStartDate" contains ""
  #Then I check I am on "Tax Cancellation Request Summary" page
  #Then I check object with xpath "//*[contains(text(), 'Cancellation Effective Date')]/..//following-sibling::td" contains "16 Jun 2017"
  #Then I click on button with value "Back"
  #Then I wait for "5000" millisecond
  #Then I enter the details as
  #| Fields                | Value      |
  #| CancellationStartDate | 16-06-2017 |
  #Then I click on button with value "Next"
  #Then I see "CancellationStartDate" contains ""
  #Then I check I am on "Tax Cancellation Request Summary" page
  #Then I check object with xpath "//*[contains(text(), 'Cancellation Effective Date')]/..//following-sibling::td" contains "16 Jun 2017"
  #Then I click on button with value "Back"
  #Then I wait for "5000" millisecond
  #Then I enter the details as
  #| Fields                | Value    |
  #| CancellationStartDate | 16-06-17 |
  #Then I click on button with value "Next"
  #Then I see "CancellationStartDate" contains ""
  #Then I check I am on "Tax Cancellation Request Summary" page
  #Then I check object with xpath "//*[contains(text(), 'Cancellation Effective Date')]/..//following-sibling::td" contains "16 Jun 2017"
  #Then I click on button with value "Back"
  #Then I wait for "5000" millisecond
  #Then I enter the details as
  #| Fields                | Value |
  #| CancellationStartDate | 16617 |
  #Then I click on button with value "Next"
  #Then I see "CancellationStartDate" contains ""
  #Then I check I am on "Tax Cancellation Request Summary" page
  #Then I check object with xpath "//*[contains(text(), 'Cancellation Effective Date')]/..//following-sibling::td" contains "16 Jun 2017"
  #Then I click on button with value "Back"
  #Then I wait for "5000" millisecond
  #Then I enter the details as
  #| Fields                | Value    |
  #| CancellationStartDate | 16062017 |
  #Then I click on button with value "Next"
  #Then I see "CancellationStartDate" contains ""
  #Then I check I am on "Tax Cancellation Request Summary" page
  #Then I check object with xpath "//*[contains(text(), 'Cancellation Effective Date')]/..//following-sibling::td" contains "16 Jun 2017"
  #
  #Examples:
  #| PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
  #| TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |
  Scenario Outline: DTSP-940: As an end user, I want to be displayed a message on forms if I do not have any ABNs linked to my account, so that I know why I cannot access them
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | taxagent1  |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I see text "Please note, as there are currently no taxpayer accounts associated with your login, there is no information to display." displayed
    Then I click on "Sign Out"
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | Test2      |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I see text "Please note, as there are currently no taxpayer accounts associated with your login, there is no information to display." displayed

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress       |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | jbradley@hotmail.c |

  @redo
  Scenario Outline: DTSP-526, 531: Update the ABN LookUp Rules for Payroll Tax Registration Form / Update the first page of the Portal Registration process
    Given I want to login to portal "<PortalName>"
    #This user has the ABN 12345678933, but since it's a tax agent user it isn't shown in the lodgement form
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Payroll Tax Registration"
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 85613104316 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I select "Other" from "SelectBusinessTypeCode"
    #Scenario 7: ABN Lookup for Inactive ABN
    Then I enter the details as
      | Fields              | Value                |
      | EmployerName        | CODAVALLI, AARADHANA |
      | BusinessTradingName | CODAVALLI, AARADHANA |
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    Then I see text "Your ABN is not valid. Please enter a valid ABN." displayed
    Then I click on "Payroll Tax Registration"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    #Then I click on button "EmployerName"
    #Then I click on button "TaxPayerDetailsNext"
    #Scenario 8:ABN Lookup for Invalid ABN
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 99999999999 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I select "Other" from "SelectBusinessTypeCode"
    Then I enter the details as
      | Fields              | Value |
      | EmployerName        | TEST  |
      | BusinessTradingName | TEST  |
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    Then I see text "Your ABN is not valid. Please enter a valid ABN." displayed
    Then I click on "Payroll Tax Registration"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    #Scenario 6: ABN Lookup for Tax Agent with an active ABN, incorrect Registered Business Name, and Entity Type is not 'Individual'
    And I enter the details as
      | Fields                 | Value |
      | RegistrationAnswer_ABN | <ABN> |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I select "Other" from "SelectBusinessTypeCode"
    Then I enter the details as
      | Fields              | Value                       |
      | EmployerName        | The Fire Company Pty Limite |
      | BusinessTradingName | The Fire Company Pty Limite |
    Then I click on button "RegistrationAnswer_ACN"
    Then I wait for "5000" millisecond
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    Then I see text "Your Organisation Name doesn't match with your ABN. Please try again." displayed
    Then I click on "Payroll Tax Registration"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    #Scenario 4: ABN Lookup for Tax Agent with an active ABN, incorrect Registered Business Name, and Entity Type = Individual
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 71583328324 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields              | Value          |
      | EmployerName        | PSALTIS, COSMA |
      | BusinessTradingName | PSALTIS, COSMA |
    Then I select "Other" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    Then I see text "Your Organisation Name doesn't match with your ABN. Please try again." displayed
    Then I click on "Payroll Tax Registration"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    #Scenario 3: ABN Lookup for Tax Agent with an active ABN, correct Registered Business Name, and Entity Type = Individual
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 71583328324 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields              | Value           |
      | EmployerName        | PSALTIS, COSMAS |
      | BusinessTradingName | PSALTIS, COSMAS |
    Then I select "Other" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    Then I enter the details as
      | Fields                    | Value      |
      | AddressLine1              | TEST       |
      | Address_City              | TEST       |
      | PostCode                  |       3333 |
      | ContactPerson_FirstName   | TEST       |
      | ContactPerson_LastName    | TEST       |
      | ContactPerson_PhoneNumber | 1234567890 |
    Then I click on "Payroll Tax Registration"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    #Scenario 5: ABN Lookup for Tax Agent with an active ABN, correct Registered Business Name, and Entity Type is not 'Individual'
    And I enter the details as
      | Fields                 | Value |
      | RegistrationAnswer_ABN | <ABN> |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Other" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    Then I enter the details as
      | Fields                    | Value      |
      | AddressLine1              | TEST       |
      | Address_City              | TEST       |
      | PostCode                  |       3333 |
      | ContactPerson_FirstName   | TEST       |
      | ContactPerson_LastName    | TEST       |
      | ContactPerson_PhoneNumber | 1234567890 |

    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |

  @review
  Scenario Outline: DTSP-966: As a Business Taxpayer registering for Payroll Tax, I want to see an updated Taxpayer details section, so that it is easier to use
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Payroll Tax Registration"
    Then I check I am on "Payroll Tax Registration Form" page
    #Scenario 1: Button
    Then I check "ABNVerify_BTN" exists
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 17118795716 |
    Then I click on button with value "Next"
    #Scenario 2: instructions
    Then I wait for "5000" millisecond
    Then I see text "You are already registered for another tax type, please provide your Customer Reference Number (CRN) below to continue registering for Payroll Tax" displayed
    Then I check "RegistrationAnswer_CRN" exists

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  @review
  Scenario Outline: DTSP-986: As an end user, I want to see updated date field on my Ambulance Levy Lodgement and Amendment forms, so that I know when my return is due
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Home"
    Then I click on "Return Lodgements"
    Then I click on "Ambulance Levy"
    Then I click on button "GeneralDiscardBt"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I select "Jun 2013" from "ObligationsDropdown"
    Then I check "ReturnDate" contains "Sep 2013"
    Then I check "ReturnDate" is readonly
    Then I click on button "SaveNextBT"
    Then I enter the details as
      | Fields                                       | Value |
      | LodgeAmbulanceLevyAnswer_NumberSingleMembers |    11 |
      | LodgeAmbulanceLevyAnswer_NumberFamilyMembers |    11 |
    Then I check "SaveAndNextToSummaryBT" is not readonly
    Then I click on button "SaveAndNextToSummaryBT"
    Then I check object with xpath "//*[contains(text(), 'Reference Period')]//following-sibling::td" contains "Jun 2013"
    Then I check object with xpath "//*[contains(text(), 'Return Date')]//following-sibling::td" contains "Sep 2013"
    Then I click on "Return History"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value          |
      | s2id_autogen1_search | <Organisation> |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I click on object with xpath "(//a[contains(@id, 'TaxTypesTabBar')])[3]"
    #Scenario 1: Pre populated fields
    Then I click on "AMEND"
    Then I check I am on "Amend Ambulance Levy Lodgement" page
    Then I check "ObligationToAmend" is readonly
    Then I check "ReturnDate" is readonly
    Then I check object with xpath "//*[contains(@id, 'ObligationToAmend')]" contents match regex "\w{3} \d{4}"
    Then I check object with xpath "//*[contains(@id, 'ReturnDate')]" contents match regex "\w{3} \d{4}"
    Then I click on button with value "Next"
    Then I click on button "SaveAndNextToSummaryBT"
    Then I check object with xpath "//*[contains(text(), 'Reference Period')]//following-sibling::td" contents match regex "\w{3} \d{4}"
    Then I check object with xpath "//*[contains(text(), 'Return Date')]//following-sibling::td" contents match regex "\w{3} \d{4}"

    Examples: 
      | PortalName | UserName | Password   | FirstName | LastName | Position   | Organisation        | ContactPhone | EmailAddress                      |
      | TSSAdmin   | jbradley | Dbresults1 | J         | Bradley  | Consultant | DESIGNATE PTY. LTD. | 04 5678 9767 | katherine.santos@dbresults.com.au |

  ###########################################################################################################
  #################################### MISSING ACTRO BUGS ################################################
  ###########################################################################################################
  @done
  Scenario Outline: Check if Update Refund Details form has the Organization section of the Declaration filled
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Tax Registration Update"
    Then I click on "Update Refund Details"
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value                |
      | s2id_autogen1_search | ABCAD DESIGN PTY LTD |
    Then I click on button "select2-results-1"
    Then I click on button "Refunds_NO"
    Then I click on button with value "Next"
    Then I check object with xpath "//*[contains(@name, 'Label_Organisation')]/parent::td/following-sibling::td" contains "ABCAD DESIGN PTY LTD"

    Examples: 
      | PortalName | UserNameField | PasswordField | UserName | Password   | CRN         | ABN         |
      | TSSAdmin   | UserNameInput | PasswordInput | jbradley | Dbresults1 | 12121212121 | 21212121212 |

  Scenario Outline: ACN field in Payroll Tax Registration Form bug
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Payroll Tax Registration"
    And I enter the details as
      | Fields                 | Value |
      | RegistrationAnswer_ABN | <ABN> |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I wait for "5000" millisecond
    Then I check "RegistrationAnswer_ACN" is empty
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields                  | Value         |
      | AddressLine1            | TEST          |
      | Address_City            | TEST          |
      | ContactPerson_FirstName | TEST          |
      | ContactPerson_LastName  | TEST          |
      | ContactPerson_Email     | TEST@TEST.com |
    Then I click on button with value "Cancel"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Given I want to login to portal "<PortalName>"
    Then I click on "Payroll Tax Registration"
    And I enter the details as
      | Fields                 | Value |
      | RegistrationAnswer_ABN | <ABN> |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields                 | Value                   |
      | EmployerName           | sadfasdfadsf            |
      | BusinessTradingName    | asdfadsfadsfasdf        |
      | RegistrationAnswer_ACN | 27349832721342134124302 |
    Then I select "Company" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    Then I see text "Your Organisation Name doesn't match with your ABN. Please try again." displayed
    Then I see text "Your ACN doesn't match with your ABN. Please try again." shown
    Then I enter the details as
      | Fields                 | Value         |
      | EmployerName           | <CompanyName> |
      | BusinessTradingName    | <CompanyName> |
      | RegistrationAnswer_ACN |     134834334 |
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields                  | Value         |
      | AddressLine1            | TEST          |
      | Address_City            | TEST          |
      | ContactPerson_FirstName | TEST          |
      | ContactPerson_LastName  | TEST          |
      | ContactPerson_Email     | TEST@TEST.com |

    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |

  Scenario Outline: Total Taxable Wages in Payroll Tax Registration dropdown bug
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Payroll Tax Registration"
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I check "RegistrationAnswer_ACN" is empty
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    #Then I select "Mr" from "ContactPerson_Title"
    # Then I select "Direct Post" from "CommunicationMethodId"
    Then I enter the details as
      | Fields                    | Value         |
      | AddressLine1              | TEST          |
      | Address_City              | TEST          |
      | ContactPerson_FirstName   | TEST          |
      | ContactPerson_LastName    | TEST          |
      | ContactPerson_Email       | TEST@TEST.com |
      | PostCode                  |          3333 |
      | ContactPerson_PhoneNumber |    1234567890 |
    Then I click on button "OrgDetailsNextBt"
    Then I wait for "5000" millisecond
    Then I click on button "select2-chosen"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search |  6940 |
    Then I click on button "select2-results"
    Then I click on button "ACTWagesPaidNextBt"
    # Then I select "FY 2011/12" from "YearComboBox"
    Then I select "FY 2012/13" from "YearComboBox"
    Then I select "FY 2013/14" from "YearComboBox"
    Then I select "FY 2014/15" from "YearComboBox"
    Then I select "FY 2015/16" from "YearComboBox"
    Then I select "FY 2016/17" from "YearComboBox"

    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |

  Scenario Outline: Current Employer Status on Dashboard bug
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I check I am on "Tooltips" page
    Then I click on "Home"
    #Independent Employer
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value            |
      | s2id_autogen1_search | Late Cut Pty Ltd |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    #change these to regex matches and find them by id once Jonathan makes the fix
    Then I check object with xpath "//*[contains(@id, 'EmployerStatus')]//div//div[contains(.,'Employer Status')]/following-sibling::div" contains "Independent Employer"
    #Group Member
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value                    |
      | s2id_autogen1_search | MEMBER CHECK PTY LIMITED |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I check object with xpath "//*[contains(@id, 'EmployerStatus')]//div//div[contains(.,'Employer Status')]/following-sibling::div" contains "Group Member in Group Number: 19"
    #DGE
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | DESIGNATE |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I check object with xpath "//*[contains(@id, 'EmployerStatus')]//div//div[contains(.,'Employer Status')]/following-sibling::div" contains "DGE in Group Number: 19"
    #DGE and JRL
    Then I click on button "select2-chosen-1"
    Then I enter the details as
      | Fields               | Value     |
      | s2id_autogen1_search | Company Y |
    Then I click on button "select2-results-1"
    Then I wait for "5000" millisecond
    Then I check object with xpath "//*[contains(@id, 'EmployerStatus')]//div//div[contains(.,'Employer Status')]/following-sibling::div" contains "Group Member (lodging itself) in Group Number: 22"

    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |

  Scenario Outline: Organisation Name on Payroll Tax Registration instead of Employer Name
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Payroll Tax Registration"
    And I enter the details as
      | Fields                 | Value       |
      | RegistrationAnswer_ABN | 80134834334 |
    Then I click on button with value "Next"
    Then I wait for "5000" millisecond
    Then I check label "Label_EmployerName" contains "Organisation Name"
    Then I enter the details as
      | Fields              | Value         |
      | EmployerName        | <CompanyName> |
      | BusinessTradingName | <CompanyName> |
    Then I select "Government" from "SelectBusinessTypeCode"
    Then I click on button "TaxPayerDetailsNextBT"
    Then I wait for "5000" millisecond
    #Then I select "Mr" from "ContactPerson_Title"
    #Then I select "Direct Post" from "CommunicationMethodId"
    Then I enter the details as
      | Fields                    | Value         |
      | AddressLine1              | TEST          |
      | Address_City              | TEST          |
      | ContactPerson_FirstName   | TEST          |
      | ContactPerson_LastName    | TEST          |
      | ContactPerson_Email       | TEST@TEST.com |
      | PostCode                  |          3333 |
      | ContactPerson_PhoneNumber |    1234567890 |
    Then I click on button "OrgDetailsNextBt"
    Then I click on button "select2-chosen"
    Then I enter the details as
      | Fields               | Value |
      | s2id_autogen1_search |  6940 |
    Then I click on button "select2-results"
    Then I click on button "ACTWagesPaidNextBt"
    #Then I enter the details as
    #| Fields             | Value  |
    #| NumberOfEmployees  |     33 |
    #| DateBusinessStart  | 010517 |
    #| DateBusinessLiable | 020517 |
    Then I enter the details as
      | Fields            | Value |
      | NumberOfEmployees |    33 |
    Then I click on button "DateBusinessStart"
    Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
    #	Then I enter the details as
    #  | DateBusinessStart  | 12032033 |
    Then I click on button "DateBusinessLiable"
    Then I click on object with xpath "//td[contains(@class, 'day selected today')]"
    #Then I enter the details as
    # | DateBusinessLiable | 12032034 |
    Then I click on button "AnnualLodgementApproval_NO"
    #Then I click on button "PayrollNext"
    Then I click on button "PayrollNext"
    Then I click on button "Refunds_NO"
    Then I wait for "5000" millisecond
    Then I click on button "RefundDetailsBT"
    Then I check label "Label_Declarer_Organisation" contains "Organisation Name"

    Examples: 
      | PortalName | CompanyName          | ABN         | UserName | Password   |
      | TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |
#@dolater
  #Scenario Outline: Group Management Create group with DGE bug
    #Given I want to login to portal "<PortalName>"
    #And I enter the details as
      #| Fields        | Value      |
      #| UserNameInput | <UserName> |
      #| PasswordInput | <Password> |
    #And I hit Enter
    #Then I click on "Group Management"
    #Then I click on button "select2-chosen-1"
    #Then I enter the details as
      #| Fields               | Value     |
      #| s2id_autogen1_search | Company Y |
    #Then I click on button "select2-results-1"
    #Then I click on button with value "Update Group"
    #Then I wait for "5000" millisecond
    #Then I select "2018" from "YearCombo"
    #Then I select "Jan" from "MonthCombo"
    #Then I click on button with value "Next"
    #Then I check I am on "Payroll Tax Group Update Summary" page
#
    #Examples: 
      #| PortalName | CompanyName          | ABN         | UserName | Password   |
      #| TSSAdmin   | Dynamic Fire Pty Ltd | 80134834334 | jbradley | Dbresults1 |
