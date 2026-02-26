PageExtension 50183 "Sales Quote Archive_PagEXT" extends "Sales Quote Archive"

{
    layout
    {

    }
    actions
    {

    }
    trigger OnOpenPage()
    VAR
    //DYS page addon non migrer;
    //   lNaviBatQuote: Page 8004057;
    BEGIN
        //NAVIBAT
        //DYS
        // lNaviBatQuote.SETTABLEVIEW(Rec);
        // lNaviBatQuote.RUNMODAL;
        // lNaviBatQuote.GETRECORD(Rec);
        CurrPage.CLOSE;
        //NAVIBAT/


    end;
}