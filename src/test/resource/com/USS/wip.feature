
Feature: Some feature

  #DONE: 1089, 1092, 1097, 1106, 1111,  1115, 1116, 1117, 1118, 1119, 1120, 1122, 1123, 1124, 1125, 1126, 1127, 1128, 1129, 1139
 @all
  Scenario Outline: DCSSP-1045: drag and drop field order

    And I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Forms"
    Then I click on object with xpath "//td[contains(text(), '<FormName>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I drag object with xpath "//td[contains(text(), 'Brand')]/.." onto object with xpath "//td[contains(text(), 'Reason')]/.."

    Examples: 
      | PortalName | UserName  | Password | FormName       |
      | USS        | christian | Aussie11 | AutomationTest |

  Scenario Outline: DCSSP-1089: As a user, I want to be to see the Forms for the Form Groups under Request and Queries, so that I can make a request relevant to my needs
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    #Scenario 1: User views the menu options in the left navigation panel
    Then I click on "REQUEST AND QUERIES"
    Then I see text "Electricity Forms" displayed
    Then I see text "Water Forms" displayed
    Then I see text "TEST" displayed
    #Scenario 2: User views the available Forms for a Form Group
    Then I click on "Electricity Forms"
    Then I select "Please Select" from "DbxSelect"
    Then I select "TESTFORM4" from "DbxSelect"

    Examples: 
      | PortalName | UserName  | Password | HasFields | NoFields        |
      | USS        | christian | Aussie11 | TESTFORM4 | AutomationTest1 |

  @review
  Scenario Outline: DSCPP-1097: add fields to a form inline
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Forms"
    Then I click on object with xpath "//td[contains(text(), '<HasFields>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I see text "Add a field" displayed
    Then I click on "Add a field"
    Then I check "FieldName" exists
    #Scenario 2 - edit field: Selecting the field allows the field to be editable.
    Then I click on "Car Description"
    Then I check "FieldName" exists
    #Scenario 1 - add field: Field can be appended to a form.
    Then I click on "Forms"
    Then I click on object with xpath "//td[contains(text(), '<HasFields>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I see text "Add a field" displayed
    Then I click on "Add a field"
    Then I check "FieldName" exists
    #Scenario 3 - remove field: Selecting a row provides an option to delete the field from the table.
    Then I click on "Car Description"
    Then I check "fa fa-fw fa-trash fa-lg" exists

    Examples: 
      | PortalName | UserName  | Password | HasFields | NoFields        |
      | USS        | christian | Aussie11 | TESTFORM4 | AutomationTest1 |

  @review
  Scenario Outline: DSCPP-1106: Add new Fields to form to From without clicking on Add new Field button
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Forms"
    Then I click on object with xpath "//td[contains(text(), '<HasFields>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I see text "Add a field" displayed
    Then I click on "Add a field"
    Then I check "FieldName" exists

    Examples: 
      | PortalName | UserName  | Password | HasFields | NoFields        |
      | USS        | christian | Aussie11 | TESTFORM4 | AutomationTest1 |

  Scenario Outline: DSCPP-1106/1111: Add new Fields to form to From without clicking on Add new Field button
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on "Christian Clarke"
    Then I see text "SETTINGS" displayed
    Then I see text "SIGN OUT" displayed
    Then I click on "SETTINGS" 
    Then I check I am on "Settings" page
    Then I click on "DASHBOARD"
    Then I click on "Christian Clarke"
    Then I click on "SIGN OUT"
    Then I check I am on "Login" page

    Examples: 
      | PortalName | UserName  | Password | HasFields | NoFields        |
      | USS        | christian | Aussie11 | TESTFORM4 | AutomationTest1 |

  @review
  Scenario Outline: DSCPP-1115/1118: As a Portal Administrator, I want to view and order Form Groups so that I can manage the groups for my Organisation
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Form Groups"
    #Scenario 1: Admin views Form Groups
    Then I check "SearchInput" is empty
    Then I see text "Form Groups" displayed
    Then I click on button with value "Search"
    Then I click on button with value "Clear"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName   |
      | item2 | Order      |
      | item3 | Group Code |
      | item4 | Group Name |
      | item6 | Is Active  |
    Then I see text "Add a new Group" displayed
    #Scenario 3: Admin unable to order Form Groups
    And I enter the details as
      | Fields      | Value |
      | SearchInput | Forms |
    And I hit Enter
    Then I check "ui-sortable" does not exist
    #Scenario 2 is hard to test due to it requiring a  specific set of entries existing, which isn't always the case.
    Then I drag object with xpath "//td[contains(text(), '<FormGroup1>')]/.." onto object with xpath "//td[contains(text(), '<FormGroup2>')]/.."

    Examples: 
      | PortalName | UserName  | Password | FormGroup1  | FormGroup2        |
      | USS        | christian | Aussie11 | Water Forms | Electricity Forms |

  @review
  Scenario Outline: DSCPP-1116: As a Portal Administrator, I want to create and edit Form Groups so that I can manage the groups for my Organisation
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Form Groups"
    Then I click on "Add a new Group"
    #Scenario 1: Admin creates Form Group - mandatory fields not filled in
    Then I click on button "fa fa-fw fa-check fa-lg"
    Then I see text "Mandatory fields not filled in." displayed
    #Scenario 2: Admin creates Form Group – Group ID not unique
    And I enter the details as
      | Fields    | Value       |
      | GroupCode | <NotUnique> |
      | GroupName | <NotUnique> |
    Then I click on button "fa fa-fw fa-check fa-lg"
    Then I see text "Group ID must be unique" displayed
    #Scenario 4: Admin cancels ‘Add Group’ function
    Then I click on button "fa fa-fw fa-times fa-lg"
    Then I see "<NotUnique>" displayed
    #Scenario 3: Admin successfully creates Form Group
    Then I click on "Add a new Group"
    Then I wait for "2000" millisecond
    And I enter the details as
      | Fields    | Value    |
      | GroupCode | <Unique> |
      | GroupName | <Unique> |
    Then I click on button "fa fa-fw fa-check fa-lg"
    Then I see text "<Unique>" displayed
    Then I click on "Form Groups"
    #Scenario 5: Admin edits Form Group – mandatory fields not filled in
    Then I click on object with xpath "//td[contains(text(), '<Unique>')]//..//span[contains(@class, 'fa-pencil')]"
    Then I wait for "2000" millisecond
    And I enter the details as
      | Fields    | Value |
      | GroupCode |       |
      | GroupName |       |
    Then I click on button "fa fa-fw fa-check fa-lg"
    Then I see text "Mandatory fields not filled in." displayed
    #Scenario 6: Admin edits Form Group – Group ID not unique
    And I enter the details as
      | Fields    | Value       |
      | GroupCode | <NotUnique> |
      | GroupName | <NotUnique> |
    Then I click on button "fa fa-fw fa-check fa-lg"
    Then I see text "Group ID must be unique" displayed
    #Scenario 8: Admin cancels edit function with unsaved changes
    Then I click on button "fa fa-fw fa-times fa-lg"
    Then I see "Are you sure you want to discard the changes made?" displayed on popup and I click "OK"
    Then I see text "<NotUnique>" displayed
    #Scenario 9: Admin cancels edit function with no unsaved changes
    Then I click on object with xpath "//td[contains(text(), '<Unique>')]//..//span[contains(@class, 'fa-pencil')]"
    Then I wait for "2000" millisecond
    Then I click on button "fa fa-fw fa-times fa-lg"
    Then I see text "<NotUnique>" displayed
    #Scenario 7: Admin successfully edits a Form Group
    Then I click on object with xpath "//td[contains(text(), '<Unique>')]//..//span[contains(@class, 'fa-pencil')]"
    Then I wait for "2000" millisecond
    And I enter the details as
      | Fields    | Value     |
      | GroupCode | <Unique>  |
      | GroupName | <Unique>2 |
    Then I click on button "fa fa-fw fa-check fa-lg"
    Then I see text "<Unique>2" displayed

    Examples: 
      | PortalName | UserName  | Password | NotUnique  | Unique        |
      | USS        | christian | Aussie11 | WaterForms | TESTFORMGROUP |

  @review
  Scenario Outline: DSCPP-1117: As a Portal Administrator, I want to delete a Form Group so that I can manage the groups for my Organisation
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Form Groups"
    #Scenario 1: Admin deletes Form Group which has Form associated
    Then I click on object with xpath "//td[contains(text(), '<CantDelete>')]//following-sibling::td//following-sibling::td//a"
    Then I see "Are you sure you want to delete this Form Group?" displayed on popup and I click "OK"
    Then I see text "Unable to delete group as there are Form Types associated to this group. Please update the group for the Form Types and try again" displayed
    #Scenario 3: Admin cancels delete function of a Form Group which has no Forms associated
    Then I click on object with xpath "//td[contains(text(), '<CanDelete>')]//following-sibling::td//following-sibling::td//a"
    Then I see "Are you sure you want to delete this Form Group?" displayed on popup and I click "Cancel"
    Then I see text "<CanDelete>" displayed
    #Scenario 2: Admin confirms deletion of a Form Group which has no Forms associated
    Then I click on object with xpath "//td[contains(text(), '<CanDelete>')]//following-sibling::td//following-sibling::td//a"
    Then I see "Are you sure you want to delete this Form Group?" displayed on popup and I click "OK"
    Then I see text "<CanDelete>" not displayed

    Examples: 
      | PortalName | UserName  | Password | CantDelete  | CanDelete     |
      | USS        | christian | Aussie11 | Water Forms | TESTFORMGROUP |

  @broken_dolater
  Scenario Outline: DSCPP-1119: As a Portal Administrator, I want to create and edit Forms so that I can manage the Forms for my Organisation
    #broken due to 'One or more web services are not working' bug
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Forms"
    Then I click on button with value "New Form"
    #Scenario 1: Admin creates a Form - mandatory fields not filled in
    Then I click on button with value "Submit"
    Then I see text "Mandatory fields not filled in." displayed
    #Scenario 2: Admin creates a Form – Form Code not unique
    And I enter the details as
      | Fields            | Value       |
      | Form_Code         | <NotUnique> |
      | FormType_FormName | <NotUnique> |
      | Form_Description  | <NotUnique> |
    Then I select "TEST" from "MainContent_wtGroup"
    Then I click on button with value "Submit"
    Then I see text "Form Code must be unique." displayed
    #
    #
    #Scenario 3: Admin successfully creates a Form
    And I enter the details as
      | Fields            | Value    |
      | Form_Code         | <Unique> |
      | FormType_FormName | <Unique> |
      | Form_Description  | <Unique> |
    Then I select "TEST" from "MainContent_wtGroup"
    Then I click on button with value "Submit"
    Then I wait for "2000" millisecond
    Then I see text "Form successfully created." displayed
    #
    #Scenario 4: Admin cancels New Form function with unsaved changes
    Then I click on button with value "New Form"
    And I enter the details as
      | Fields            | Value    |
      | Form_Code         | <Unique> |
      | FormType_FormName | <Unique> |
      | Form_Description  | <Unique> |
    Then I click on button with value "Cancel"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "Cancel"
    Then I check I am on "Create New Form" page
    Then I click on button with value "Cancel"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Then I check I am on "Forms" page
    #
    #
    #
    #Scenario 5: Admin cancels New Form function with no unsaved changes
    Then I click on button with value "New Form"
    Then I click on button with value "Cancel"
    Then I check I am on "Forms" page
    #Scenario 6: Admin edits Form – mandatory fields not filled in
    #click on the pencil icon that allows editing
    Then I click on object with xpath "//td[contains(text(), '<Unique>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I check I am on "<Unique>" page
    #Scenario 7: Admin edits Form – Form Code not unique
    And I enter the details as
      | Fields            | Value       |
      | Form_Code         | <NotUnique> |
      | FormType_FormName | <NotUnique> |
      | Form_Description  | <NotUnique> |
    Then I click on button with value "Submit"
    Then I see text "Form Code must be unique." displayed
    #Scenario 8: Admin successfully edits a Form
    And I enter the details as
      | Fields            | Value     |
      | Form_Code         | <Unique>  |
      | FormType_FormName | <Unique>  |
      | Form_Description  | <Unique>2 |
    Then I click on button with value "Submit"
    Then I see text "Form updated successfully." displayed
    Then I check I am on "<Unique>2" page
    #Scenario 9: Admin cancels edit function with unsaved changes
    And I enter the details as
      | Fields           | Value    |
      | Form_Description | <Unique> |
    Then I click on button with value "Cancel"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "Cancel"
    Then I click on button with value "Cancel"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Then I check I am on "Create New Form" page
    #Scenario 10: Admin cancels edit function with no unsaved changes
    Then I click on object with xpath "//td[contains(text(), '<Unique>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I click on button with value "Cancel"
    Then I check I am on "Create New Form" page

    Examples: 
      | PortalName | UserName  | Password | NotUnique      | Unique          |
      | USS        | christian | Aussie11 | AutomationTest | AutomationTest1 |

  @review
  Scenario Outline: DSCPP-1120: As a Portal Administrator, I want to delete a Form so that I can manage the groups for my Organisation
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Forms"
    #Scenario 1: Admin deletes Form with associated Fields
    Then I click on object with xpath "//td[contains(text(), '<HasFields>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I click on button with value "Delete"
    Then I see text "There are Fields associated to this Form. Please remove the fields on the Form and try again." displayed
    #Scenario 3: Admin cancels delete function of a Form which has no Fields associated
    Then I click on "Forms"
    Then I click on object with xpath "//td[contains(text(), '<NoFields>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I click on button with value "Delete"
    Then I see "Are you sure you want to delete this Form?" displayed on popup and I click "Cancel"
    Then I check I am on "<NoFields>" page
    #Scenario 2: Admin confirms deletion of a Form which has no Fields associated
    Then I click on button with value "Delete"
    Then I see "Are you sure you want to delete this Form?" displayed on popup and I click "OK"
    Then I check I am on "Forms" page
    Then I see text "<NoFields>" not displayed

    Examples: 
      | PortalName | UserName  | Password | HasFields | NoFields        |
      | USS        | christian | Aussie11 | TESTFORM4 | AutomationTest1 |

  Scenario Outline: DSCPP-1122: As a Portal Administrator, I want the menu items for Installation Settings in the Admin tool logically ordered so that I can quickly find the menu I need
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "Utilities Installation Settings"
    And I see text "Organisation" displayed
    And I see text "Logo Configuration" displayed
    And I see text "Phone Codes" displayed
    And I see text "Languages" displayed
    And I see text "System" displayed
    And I see text "Services" displayed
    And I see text "Types of Usage" displayed
    And I see text "Meter Types" displayed
    And I see text "Cache" displayed
    And I see text "Billing Labels" displayed
    And I see text "Neighbourhood Watch Config" displayed
   #And I see text "CSR User Accounts" displayed
    And I see text "CSR Search Fields" displayed

    Examples: 
      | PortalName | UserName  | Password | NotUnique | Unique        |
      | USS        | christian | Aussie11 | eMail     | AUTOMATEDTEST |

  @review
  Scenario Outline: DSCPP-1123: As a Portal Administrator, I want to view the Driver Configurations so that I can see all the Driver Configurations created for my Organisation
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Form Driver Configuration"
    #Scenario 1: Admin views Form Groups
    Then I check "SearchInput" is empty
    Then I see text "Form Groups" displayed
    Then I click on button with value "Search"
    Then I click on button with value "Clear"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName    |
      | item2 | Driver Code |
      | item3 | URL         |
      | item4 | Driver Name |
      | item2 | Description |
    Then I click on button with value "New Driver"

    #Scenario 2 is hard to test due to it requiring a  specific set of entries existing, which isn't always the case.
    Examples: 
      | PortalName | UserName  | Password |
      | USS        | christian | Aussie11 |

	
  Scenario Outline: DSCPP-1124: As a Portal Administrator, I want to create and edit Driver Configurations so that I can manage the Forms for my Organisation
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Form Driver Configuration"
    Then I click on button with value "New Driver"
    #Scenario 1: Admin creates Driver Configuration - mandatory fields not filled in
    Then I click on button with value "Submit"
    Then I see text "Mandatory fields not filled in." displayed
    #Scenario 2: Admin creates Driver Configuration – Code not unique
    And I enter the details as
      | Fields                   | Value       |
      | CustomFormURLDriver_Code | <NotUnique> |
      | CustomFormURLDriver_Name | <NotUnique> |
      | CustomFormURLDriver_URL  | <NotUnique> |
    Then I click on button with value "Submit"
    Then I see text "Driver Code must be unique." displayed
    #Scenario 3: Admin successfully creates Driver Configuration
    And I enter the details as
      | Fields                   | Value    |
      | CustomFormURLDriver_Code | <Unique> |
      | CustomFormURLDriver_Name | <Unique> |
      | CustomFormURLDriver_URL  | <Unique> |
    Then I click on button with value "Submit"
    Then I wait for "2000" millisecond
    Then I see text "Driver Configuration successfully created." displayed
    #Scenario 4: Admin cancels Add Driver Configuration function with unsaved changes
    Then I click on button with value "New Driver"
    And I enter the details as
      | Fields                   | Value    |
      | CustomFormURLDriver_Code | <Unique> |
      | CustomFormURLDriver_Name | <Unique> |
      | CustomFormURLDriver_URL  | <Unique> |
    Then I click on button with value "Cancel"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "Cancel"
    Then I check I am on "New Custom Form URLDriver" page
    Then I click on button with value "Cancel"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Then I check I am on "Form Driver Configurations" page
    #Scenario 5: Admin cancels Add Driver Configuration function with no unsaved changes
    Then I click on button with value "New Driver"
    Then I click on button with value "Cancel"
    Then I check I am on "Form Driver Configurations" page
    #Scenario 6: Admin edits Driver Configuration – mandatory fields not filled in
    Then I click on object with xpath "//td[contains(text(), '<Unique>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I check I am on "<Unique>" page
    #Scenario 7: Admin edits Form – Form Code not unique
    And I enter the details as
      | Fields                   | Value       |
      | CustomFormURLDriver_Code | <NotUnique> |
      | CustomFormURLDriver_Name | <NotUnique> |
      | CustomFormURLDriver_URL  | <NotUnique> |
    Then I click on button with value "Submit"
    Then I see text "Driver Code must be unique." displayed
    #Scenario 8: Admin successfully edits a Driver Configuration
    And I enter the details as
      | Fields                   | Value     |
      | CustomFormURLDriver_Code | <Unique>  |
      | CustomFormURLDriver_Name | <Unique>  |
      | CustomFormURLDriver_URL  | <Unique>2 |
    Then I click on button with value "Submit"
    Then I see text "Driver Configuration updated successfully." displayed
    Then I click on object with xpath "//td[contains(text(), '<Unique>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I check I am on "<Unique>" page
    #Scenario 9: Admin cancels edit function with unsaved changes
    And I enter the details as
      | Fields                   | Value    |
      | CustomFormURLDriver_Code | <Unique> |
    Then I click on button with value "Cancel"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "Cancel"
    Then I click on button with value "Cancel"
    Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Then I check I am on "Form Driver Configurations" page
    #Scenario 10: Admin cancels edit function with no unsaved changes
    Then I click on object with xpath "//td[contains(text(), '<Unique>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I click on button with value "Cancel"
    Then I check I am on "Form Driver Configurations" page

    Examples: 
      | PortalName | UserName  | Password | NotUnique | Unique        |
      | USS        | christian | Aussie11 | eMail     | AUTOMATEDTEST |

  
  Scenario Outline: DSCPP-1125/1126: As a Portal Administrator, I want to delete a Driver Configuration so that I can manage the Drivers for my Organisation
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Form Driver Configuration"
    #Scenario 1: Admin deletes Driver Configuration with Form Types associated
    Then I click on object with xpath "//td[contains(text(), '<Associated>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I click on button with value "Delete"
    Then I see text "There are Forms associated to this Driver Configuration. Please update the Driver on the Forms and try again." displayed
    #Scenario 2: Admin deletes Driver Configuration which has no Form Types associated
    Then I click on "Form Driver Configuration"
    Then I click on object with xpath "//td[contains(text(), '<NoAssociation>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I click on button with value "Delete"
    #Scenario 3: Admin cancels delete function of a Driver Configuration which is not associated to a Form
    Then I see "Are you sure you want to delete this Driver?" displayed on popup and I click "Cancel"
    Then I check I am on "<NoAssociation>" page
    Then I click on button with value "Delete"
    Then I see "Are you sure you want to delete this Driver?" displayed on popup and I click "OK"
    Then I see text "Driver successfully deleted" displayed

    Examples: 
      | PortalName | UserName  | Password | Associated | NoAssociation |
      | USS        | christian | Aussie11 | EMAIL      | AUTOMATEDTEST   |

  #@dolater
  #Scenario Outline: DSCPP-1120: As a Portal Administrator, I want to delete a Form so that I can manage the groups for my Organisation
  #Given I want to login to portal "<PortalName>"
  #And I enter the details as
  #| Fields        | Value      |
  #| UserNameInput | <UserName> |
  #| PasswordInput | <Password> |
  #And I hit Enter
  #And I want to login to portal "USSAdmin"
  #Then I click on "CUSTOM FORMS"
  #Then I click on "Forms"
  #Then I click on button with value "New Form"
  #
  #Scenario 1: Admin creates a new Form
  #Then I check the values of dropdown "RouteTypesChoice" are alphabetical
  #Then I select "eMail - SendEmailType1" from "RouteTypesChoice"
  #Then I wait for "2000" millisecond
  #Then I click on object with xpath "//*[contains(text(), '<FieldName>')]/following-sibling::td/input"
  #
  #Scenario 2: Admin edits an existing Form
  #Then I click on "Forms"
  #Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
  #
  #Then I click on object with xpath "//td[contains(text(), '<FormName>')]/..//span[contains(@class, 'fa-pencil')]"
  #Then "RouteTypesChoice" displays "eMail - SendEmailType1" by default
  #
  #Scenario 3: Admin saves a Form
  #
  #Then I click on button with value "Submit"
  #Then I see text "Form saved successfully." displayed
  #
  #
  #
  #Examples:
  #| PortalName | UserName  | Password | FieldName | FormName        |
  #| USS        | christian | Aussie11 | EmailAddress | AutomationTest |
  @review
  Scenario Outline: DSCPP-1127: As a Portal Administrator, I want to view and order Form Fields so that I can manage the Forms for my Organisation
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Forms"
    #Scenario 1: Admin views a Form with no Fields added
    Then I click on object with xpath "//td[contains(text(), 'Formtest23')]/..//span[contains(@class, 'fa-pencil')]"
    Then I see text "Add a field" displayed
    Then I check object with xpath "//th[contains(text(), 'Field')]" exists
    Then I check object with xpath "//th[contains(text(), 'Type')]" exists
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName  |
      #| Item3   | 	Field     |
      #| Item4   | Type    |
      | Item6 | Tooltip   |
      | Item7 | Mandatory |
    Then I click on "Forms"
    #Scenario 2: Admin views a Form with Fields added
    Then I click on object with xpath "//td[contains(text(), '<FormName>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I see text "Add a field" displayed
    Then I check object with xpath "//th[contains(text(), 'Field')]" exists
    Then I check object with xpath "//th[contains(text(), 'Type')]" exists
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName  |
      #| Item3   | 	Field     |
      #| Item4   | Type    |
      | Item6 | Tooltip   |
      | Item7 | Mandatory |
    Then I click on "Forms"

    Examples: 
      | PortalName | UserName  | Password | FormName                  | NewField        |
      | USS        | christian | Aussie11 | AutomationTestDONOTDELETE | Premise Address |

 
  Scenario Outline: DSCPP-1128: add fields to a form inline
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Forms"
    Then I click on object with xpath "//td[contains(text(), '<FormName>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I see text "Add a field" displayed
    Then I click on "Add a field"
    Then I check "FieldName" exists
    #Scenario 1: Admin adds a field to a Form
    And I enter the details as
      | Fields    | Value      |
      | FieldName | <NewField> |
    Then I click on "<NewField>"
    Then I click on button "fa fa-fw fa-check fa-lg"
    Then I see text "Add a field" not displayed
    Then I click on button with value "Submit"
    #		Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Then I click on "Forms"
    Then I click on object with xpath "//td[contains(text(), '<FormName>')]/..//span[contains(@class, 'fa-pencil')]"
    #Scenario 2: Admin edits a field on a Form
    Then I click on "Forms"
    Then I click on object with xpath "//td[contains(text(), '<FormName>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I click on "Car Description"
    Then I wait for "2000" millisecond
    And I enter the details as
      | Fields    | Value      |
      | FieldName | <NewField> |
    Then I click on "<NewField>"
    Then I click on button "fa fa-fw fa-check fa-lg"
    Then I see text "<NewField>" displayed
    Then I see text "Car Description" not displayed
    #Scenario 3: Admin closes field detail view
    Then I check "FieldName" exists
    Then I click on button "fa fa-fw fa-times fa-lg"
    Then I check "FieldName" does not exist
    Then I click on button with value "Cancel"

    #		Then I see "Are you sure you want to discard changes made?" displayed on popup and I click "OK"
    Examples: 
      | PortalName | UserName  | Password | FormName       | NewField        |
      | USS        | christian | Aussie11 | AutomationTest | Premise Address |

   Scenario Outline: DSCPP-1129: As a Portal Administrator, I want to delete a Field from a Form so that I can manage the Forms for my Organisation
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Forms"
    Then I click on object with xpath "//td[contains(text(), '<FormName>')]/..//span[contains(@class, 'fa-pencil')]"
    Then I see text "Add a field" displayed
    Then I click on "Add a field"
    Then I check "FieldName" exists
    #Scenario 2: Admin cancels Delete function of a Field on a Form
    Then I click on "<NewField>"
    Then I click on button "fa fa-fw fa-trash fa-lg"
    Then I see "Are you sure you want to delete this Field from the Form?" displayed on popup and I click "Cancel"
    Then I see text "<NewField>" displayed
    #Scenario 1: Admin confirms deletion of a Field on a Form
    #Then I click on "<NewField>"
    Then I click on button "fa fa-fw fa-trash fa-lg"
    Then I see "Are you sure you want to delete this Field from the Form?" displayed on popup and I click "OK"
    Then I see text "<NewField>" not displayed
    #Scenario 3: User views Form in the Portal
    And I want to login to portal "<PortalName>"
    Then I click on "REQUEST AND QUERIES"
    Then I click on "Electricity Forms"
    Then I select "AutomationTestDONOTDELETE" from "DbxSelect"
    Then I see text "<NewField>" not displayed

    Examples: 
      | PortalName | UserName  | Password | FormName       | NewField        |
      | USS        | christian | Aussie11 | AutomationTest | Premise Address |
	
	 
  Scenario Outline: DCSSP-1139: As an Administrator, I want the 'Description' field in the 'Fields' menu to be updated to 'Tooltip' so that the terminology is consistent across the custom form pages.
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "CUSTOM FORMS"
    Then I click on "Fields"
    Then I click on button with value "New Field"
    #Scenario 1: Admin creates a new Custom Form Field
    Then I click on button with value "Save"
    Then I check "Field_Description" has CSS property "border-color" with value "rgb(191, 22, 1)"
    #Scenario 2: Admin edits an existing Custom Form Field
    Then I click on "Fields"
    Then I click on button "fa fa-fw fa-pencil"
    And I enter the details as
      | Fields            | Value |
      | Field_Description |       |
    Then I click on button with value "Save"
    Then I check I am on "Field List" page

    Examples: 
      | PortalName | UserName  | Password | FormName       | NewField        |
      | USS        | christian | Aussie11 | AutomationTest | Premise Address |
      
      
   
    Scenario Outline: DCSSP-1096: As a Portal Administrator, I want to select which fields are required when searching for a customer so that CSR Agents know the data they need to provide
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    And I want to login to portal "USSAdmin"
    Then I click on "Utilities Installation Settings"
    Then I click on "CSR Search Fields"
    
    #Scenario 1: Portal Administrator views Customer Search Verification page 
    
    Then I check object with xpath "//div[contains(text(), 'Account No.')]/../..//input" exists
    Then I check object with xpath "//div[contains(text(), 'Username')]/../..//input" exists
    Then I check object with xpath "//div[contains(text(), 'Mobile No.')]/../..//input" exists
    Then I check object with xpath "//div[contains(text(), 'Email')]/../..//input" exists
    Then I check object with xpath "//div[contains(text(), 'Customer Name')]/../..//input" exists
    
    
    #Scenario 2: Portal Administrator updates CSR Search Criteria 
    Then I click on checkbox with xpath "//div[contains(text(), 'Account No.')]/../..//input" until it is "checked"
    Then I click on checkbox with xpath "//div[contains(text(), 'Username')]/../..//input" until it is "checked"
    Then I click on checkbox with xpath "//div[contains(text(), 'Mobile No.')]/../..//input" until it is "checked"
    Then I click on checkbox with xpath "//div[contains(text(), 'Email')]/../..//input" until it is "checked"
    Then I click on checkbox with xpath "//div[contains(text(), 'Customer Name')]/../..//input" until it is "checked"
    
    Then I click on button with value "Submit"
    
    Then I click on "Sign Out"
     And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName2> |
      | PasswordInput | <Password2> |
    And I hit Enter
    
    Then I click on "Search"
    Then I check "RightColumn_wtAccountNumber" exists
    Then I check "RightColumn_wtUserName" exists
    Then I check "RightColumn_wtMobilePhone" exists
    Then I check "RightColumn_wtEmail" exists
    Then I check "RightColumn_wtClientName" exists
    
    Then I click on "Sign Out"
     And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
    And I hit Enter
    
    And I want to login to portal "USSAdmin"
    Then I click on "Utilities Installation Settings"
    Then I click on "CSR Search Fields"
    
     Then I click on checkbox with xpath "//div[contains(text(), 'Account No.')]/../..//input" until it is "unchecked"
    Then I click on checkbox with xpath "//div[contains(text(), 'Username')]/../..//input" until it is "checked"
    Then I click on checkbox with xpath "//div[contains(text(), 'Mobile No.')]/../..//input" until it is "unchecked"
    Then I click on checkbox with xpath "//div[contains(text(), 'Email')]/../..//input" until it is "unchecked"
    Then I click on checkbox with xpath "//div[contains(text(), 'Customer Name')]/../..//input" until it is "unchecked"
    Then I click on button with value "Submit"
     Examples: 
      | PortalName | UserName  | UserName2 | Password | Password2 | FormName       | NewField        |
      | USS        | christian | Maxx | Aussie11 | Aussie | AutomationTest | Premise Address |

      @wip
     Scenario Outline: DCSSP-1092: As a CSR agent, I should only see customers that return an exact match to my search criteria so that I’m prevented from searching across the entire database for security purposes
     Given I want to login to portal "<PortalName>"
     And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <UserName> |
      | PasswordInput | <Password> |
     And I hit Enter
     
     #Scenario 1: CSR user/CSR Team Leader conducts a search 
     Then I click on "Search"
     
     And I enter the details as
      | Fields        | Value      |
      | RightColumn_wtUserName | christian |
    Then I click on button with value "Search"
    Then I wait for "2000" millisecond
    #Then I click on "Customer Name"
      #Then "<Item>" is displayed as "<ItemName>"
      #| Item  | ItemName  |
      #| Item6 | Account Nº   |
      #| Item7 | Username |
      #| Item7 | Customer Name |
      #| Item7 | Email |
      #| Item7 | Mailing Address |
     # | Item7 | Mobile Nº |
     Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName  |
      | Item6 | 6061134434   |
      | Item7 | CHRISTIAN |
      | Item7 | Christian Clarke |
      | Item7 | test3@dbresults.com.au |
     # | Item7 | Mailing Address |
      | Item7 | +610410924377 |
    #Scenario 2: CSR user/CSR Team Leader clears search 

	
    Then I click on button with value "Clear"
    Then I see text "Account Nº" not displayed
    Then I see text "Username" not displayed
    Then I see text "Customer Name" not displayed
    Then I see text "Email" not displayed
    Then I see text "Mailing Address" not displayed
    Then I see text "Mobile Nº" not displayed
    
    Examples: 
      | PortalName | UserName  | Password | FormName       | NewField        |
      | USS        | Maxx | Aussie | AutomationTest | Premise Address |
      
    #@wip
    #Scenario Outline: DCSSP-1111: Update top header
    #Given I want to login to portal "<PortalName>"
    #And I enter the details as
      #| Fields        | Value      |
      #| UserNameInput | <UserName> |
      #| PasswordInput | <Password> |
    #And I hit Enter
    #Then I see text "Christian Clarke" displayed
    #
    #
      #Examples: 
      #| PortalName | UserName  | Password | FormName       | NewField        |
      #| USS        | christian | Aussie11 | AutomationTest | Premise Address |
    