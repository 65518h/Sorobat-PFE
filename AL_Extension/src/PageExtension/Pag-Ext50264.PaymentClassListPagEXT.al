PageExtension 50264 "Payment Class List_PagEXT" extends "Payment Class List"
{


    layout
    {

    }
    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        /* IF UserSetup."Agent Caisse Vente" = TRUE THEN BEGIN
             rec.FILTERGROUP(2);
             rec.SETRANGE(Visible, TRUE);
             rec.FILTERGROUP(0);
         END;
         IF UserSetup.Site <> '' THEN BEGIN
             rec.FILTERGROUP(2);
             rec.SETRANGE(Site, UserSetup.Site);
             rec.FILTERGROUP(0);
         END;*/
        //>> HJ DSFT 10 12 2010
        GetFiltreTyperegUSer();
        //>> HJ DSFT 10 12 2010
    end;



    PROCEDURE GetFiltreTyperegUSer();
    BEGIN
        //>> HJ DSFT 10 12 2010
        RecAutorisationTypesRegelemen2.SETRANGE(Utilisateur, UPPERCASE(USERID));
        IF RecAutorisationTypesRegelemen2.ISEMPTY THEN EXIT;
        IF RecPaymentClass.FINDFIRST THEN
            REPEAT
                IF RecAutorisationTypesRegelement.GET(UPPERCASE(USERID), RecPaymentClass.Code) THEN
                    RecPaymentClass.MARK(TRUE);
            UNTIL RecPaymentClass.NEXT = 0;
        RecPaymentClass.MARKEDONLY(TRUE);
        rec.COPY(RecPaymentClass);
        //>> HJ DSFT 10 12 2010
    END;

    PROCEDURE GetCaisse(ParaCAisse: Text[1]);
    BEGIN
        GCaisse := ParaCAisse;
    END;


    VAR

        UserSetup: Record "User Setup";

        RecAutorisationTypesRegelement: Record "Autorisation Types Réglement2";
        RecAutorisationTypesRegelemen2: Record "Autorisation Types Réglement2";
        RecPaymentClass: Record "Payment Class";
        GCaisse: Text[1];

        Text001: Label 'You are not authorized ... No type of payment, please consult your administrator';


}