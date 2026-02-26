PageExtension 50136 "Items by Location_PagEXT" extends "Items by Location"
{

    layout
    {

    }


    PROCEDURE FiltreMagasin2();
    VAR
        LUserSetup: Record "User Setup";
    BEGIN

        // >> HJ SORO 11-07-2014
        //DYS a verifier
        //  Currpage.ItemAvailMatrix.MatrixRec.SETRANGE(Code);
        IF LUserSetup.GET(UPPERCASE(USERID)) THEN BEGIN
            //DYS a verifier
            //  IF LUserSetup."Filtre Magasin" <> '' THEN
            //    Currpage.ItemAvailMatrix.MatrixRec.SETRANGE(Code, LUserSetup."Filtre Magasin");
        END;
        // >> HJ SORO 11-07-2014
    END;
}

