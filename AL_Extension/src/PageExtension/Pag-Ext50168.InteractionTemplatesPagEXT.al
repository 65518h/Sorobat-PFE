PageExtension 50168 "Interaction Templates_PagEXT" extends "Interaction Templates"

{

    layout
    {
        modify(Attachment)
        {

            trigger OnAssistEdit()
            begin
                //+REF+MAILING
                rec.VALIDATE("Direct Mailing Code");
                //+REF+MAILING//
            end;
        }

        addafter("Campaign Target")
        {
            field("Direct Mailing Code"; Rec."Direct Mailing Code")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        modify(Open)
        {
            trigger OnAfterAction()

            begin
                //+REF+MAILING
                rec.VALIDATE("Direct Mailing Code");
                //+REF+MAILING//
            end;
        }
        modify(Create)
        {
            trigger OnAfterAction()

            begin
                //+REF+MAILING
                rec.VALIDATE("Direct Mailing Code");
                //+REF+MAILING//
            end;
        }

        modify("Copy &from")
        {
            trigger OnAfterAction()

            begin
                //+REF+MAILING
                rec.VALIDATE("Direct Mailing Code");
                //+REF+MAILING//
            end;
        }
        modify(Import)
        {
            trigger OnAfterAction()

            begin
                //+REF+MAILING
                rec.VALIDATE("Direct Mailing Code");
                //+REF+MAILING//
            end;
        }

        modify("E&xport")
        {

            trigger OnAfterAction()

            begin
                //+REF+MAILING
                rec.VALIDATE("Direct Mailing Code");
                //+REF+MAILING//
            end;
        }
    }
}

