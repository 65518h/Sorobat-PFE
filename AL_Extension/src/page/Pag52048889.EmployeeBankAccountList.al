page 52048889 "Employee Bank Account List"
{
    //GL2024  ID dans Nav 2009 : "39001410"
    Caption = 'Employee Bank Account List';
    DataCaptionFields = "Employee No.";
    Editable = true;
    PageType = List;
    SourceTable = "Employee Bank Account";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Employee No."; rec."Employee No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Post Code"; rec."Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Country Code"; rec."Country Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Fax No."; rec."Fax No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Contact; rec.Contact)
                {
                    ApplicationArea = all;
                }
                field("Bank Account No."; rec."Bank Account No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Language Code"; rec."Language Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("&Bank Acc.1")
            {
                Caption = '&Bank Acc.';
                actionref(Card1; Card) { }
            }
        }
        area(navigation)
        {
            group("&Bank Acc.")
            {
                Caption = '&Bank Acc.';
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = page "Employee Bank Account Card";
                    RunPageLink = /*GL2024 Field1*/ code = FIELD("Employee No."),
                                  /*GL2024Field2*/ Name = FIELD(Code);
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
    }
}

