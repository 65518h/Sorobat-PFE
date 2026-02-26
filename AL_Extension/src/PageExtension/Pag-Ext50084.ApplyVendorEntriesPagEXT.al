PageExtension 50084 "Apply Vendor Entries_PagEXT" extends "Apply Vendor Entries"
{
    /*GL2024 SourceTableView=WHERE(Simulation=FILTER(No),
                          Etat Facture=FILTER(' '));*/
    layout
    {
        addafter("Posting Date")
        {
            /* field("Etat Facture"; Rec."Etat Facture")
             {
                 Editable = false;
                 ApplicationArea = all;
             }*/
        }

        addafter("Amount to Apply")
        {
            field("Value Date"; Rec."Value Date")
            {
                ApplicationArea = all;
            }
        }

        addafter("Global Dimension 2 Code")
        {
            /*  field("Code Lettrage"; Rec."Code Lettrage")
              {
                  ApplicationArea = all;
              }*/
        }


    }

    trigger OnOpenPage()
    begin
        /* Rec.FilterGroup(0);
         Rec.SetRange(Simulation, false);
         Rec.SetRange("Etat Facture", rec."Etat Facture"::" ");
         Rec.FilterGroup(2);**/
    end;
}



