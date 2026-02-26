PageExtension 50173 "Task List_PagEXT" extends "Task List"

{

    layout
    {
        addafter(Date)
        {
            field("Opportunity Description"; Rec."Opportunity Description")
            {
                ApplicationArea = all;
                Visible = "Opportunity DescriptionVISIBLE";
            }
        }
        modify("Contact Company Name")
        {
            Visible = "Contact Company NameVISIBLE";
        }
    }
    actions
    {
        addafter(MakePhoneCall)
        {
            action(Close)
            {
                Caption = 'Close';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    //+REF+OPPORT
                    rec.TESTFIELD("No.");
                    rec.TESTFIELD(Closed, FALSE);
                    rec.VALIDATE(Closed, TRUE);
                    rec.MODIFY(TRUE);
                    //+REF+OPPORT//
                end;
            }
        }
        addafter(Category_Process)
        {
            actionref(Close1; Close)
            {

            }
        }
    }

    trigger OnOpenPage()
    begin


        //+REF+OPPORT
        "Contact Company NameVISIBLE" := (rec.GETFILTER("Contact Company Name") = '');
        "Opportunity DescriptionVISIBLE" := (rec.GETFILTER("Opportunity Description") = '');
        //+REF+OPPORT//
    end;

    var
        "Contact Company NameVISIBLE": Boolean;
        "Opportunity DescriptionVISIBLE": Boolean;

}