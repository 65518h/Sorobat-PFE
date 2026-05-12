PageExtension 50009 "Location List_PagEXT" extends "Location List"
{
    //Editable = false;
    layout
    {
        addafter(Name)
        {
            field("Bon de sortie Nos."; Rec."Bon de sortie Nos.")
            {
                ApplicationArea = all;
                Caption = 'Bon de sortie Nos.';
                ToolTip = 'Bon de sortie Nos.';
            }
            field("Bon d entree Nos."; Rec."Bon d entree Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bon d''entrée Nos. field.', Comment = '%';
            }
            field(Affaire; Rec.Affaire)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Affaire field.', Comment = '%';
            }
            field("No. Series Gasoil"; Rec."No. Series Gasoil")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the N° de Souche  Gasoil field.', Comment = '%';
            }
            /*   field(Affectation; rec.Affectation) 
               {
                   ApplicationArea = all;
                   Caption = 'Affectation';

               }*/


        }


    }

    var
        RecLocation: Record Location;
    // RecAutorisationMagasin: Record "Autorisation Magasin";



    PROCEDURE FiltreMagasin();
    VAR
        LUserSetup: Record "User Setup";
    BEGIN
        // >> HJ SORO 11-07-2014
        IF LUserSetup.GET(UPPERCASE(USERID)) THEN BEGIN
            //  IF LUserSetup."Filtre Magasin" <> '' THEN rec.SETFILTER(Code, '=%1', LUserSetup."Filtre Magasin");
        END;
        // >> HJ SORO 11-07-2014
    END;



    trigger OnOpenPage()
    VAR
        Compteur: Integer;
        RecLUserSetup: Record "User Setup";
    BEGIN

        //FiltreMagasin;
        Compteur := 0;
        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE);
        // RB SORO 09/06/2015
        RecLUserSetup.get(UserId);
        rec.FilterGroup(2);
        if RecLUserSetup.Affaire <> '' then
            rec.SetRange(Affaire, RecLUserSetup.Affaire);
        rec.FilterGroup(0);
        /*GL2024 Pour test    IF RecLocation.FINDFIRST THEN
                REPEAT
                    RecAutorisationMagasin.RESET;
                    RecAutorisationMagasin.SETRANGE("Code Utilisateur", UPPERCASE(USERID));
                    RecAutorisationMagasin.SETRANGE("Code Magasin", RecLocation.Code);
                    IF RecAutorisationMagasin.FINDFIRST THEN BEGIN
                        Compteur += 1;
                        RecLocation.MARK := TRUE;
                    END;
                UNTIL RecLocation.NEXT = 0;
            RecLocation.MARKEDONLY(TRUE);
            rec.COPY(RecLocation);*/


        // RB SORO 09/06/2015
    END;

    trigger OnAfterGetRecord()
    BEGIN
        //FiltreMagasin()
    END;

}