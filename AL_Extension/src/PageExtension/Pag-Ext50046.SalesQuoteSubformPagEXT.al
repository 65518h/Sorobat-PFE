PageExtension 50046 "Sales Quote Subform_PagEXT" extends "Sales Quote Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Appliquer BIC"; Rec."Appliquer BIC")
            {
                ApplicationArea = All;
                Caption = 'Appliquer BIC';
            }

        }


    }
    PROCEDURE wShowDescriptio();
    VAR
        lDescription: Record "Description Line";
    BEGIN
        rec.TESTFIELD("Line No.");
        lDescription.ShowDescription(DATABASE::"Sales Line", rec."Document Type", rec."Document No.", rec."Line No.");
    END;

    PROCEDURE wCopyStructure();
    VAR
    //DYS REPORT addon non migrer
    // lCopyStructure: Report 8004070;
    BEGIN
        //OUVRAGE
        CurrPage.SAVERECORD;
        //DYS
        // CLEAR(lCopyStructure);
        // lCopyStructure.USEREQUESTFORM(TRUE);
        // lCopyStructure.SetSalesLine(Rec);
        // lCopyStructure.RUNMODAL;
        //lUpdateTempTable;
        CurrPage.UPDATE(FALSE);
        //OUVRAGE//
    END;

    var
        wItem: Record Item;
        wNavibatSetup: Record NavibatSetup;
}


