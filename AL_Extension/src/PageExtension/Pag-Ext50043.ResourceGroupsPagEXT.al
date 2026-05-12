PageExtension 50043 "Resource Groups_PagEXT" extends "Resource Groups"
{
    layout
    {

        addafter("No.")
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = all;
            }


        }

        addafter(Name)
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
            field("Default Time per Day (h)"; Rec."Default Time per Day (h)")
            {
                ApplicationArea = all;
            }
            field("Tree Code"; Rec."Tree Code")
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        addafter("Dimensions-&Multiple")
        {
            /*  //DYS  action(Resources)
              {
                  Caption = 'Resources';
                  ApplicationArea = all;
                  trigger OnAction()
                  VAR
                      lResGr: Record "Resource / Resource Group";
                  BEGIN

                      lResGr.SETRANGE("Resource Group No.", rec."No.");
                      //lResGr.SETRANGE("Type filter",Type);
                      //DYS page addon non migrer

                      //PAGE.RUNMODAL(PAGE::"Resources / Resource Groups", lResGr);

                  end;
              }*/
        }
    }
    trigger OnOpenPage()
    BEGIN
        //RESSOURCE
        //RTC2009
        //Currpage.EDITABLE( NOT Currpage.LOOKUPMODE);
        gEditable := NOT Currpage.LOOKUPMODE;
        Currpage.EDITABLE(gEditable);
        //RTC2009
        //RESSOURCE//

    end;

    PROCEDURE wSetSelection(VAR pResGr: Record "Resource Group");
    BEGIN
        //PREPAIE
        CurrPage.SETSELECTIONFILTER(pResGr);
        //PREPAIE//
    END;

    PROCEDURE wGetSelectionFilter(): Code[80];
    VAR
        lResGr: Record "Resource Group";
        lFirst: Text[20];
        lLast: Text[20];
        lSelectionFilter: Code[80];
        lResGrCount: Integer;
        lMore: Boolean;
    BEGIN
        //PREPAIE
        CurrPage.SETSELECTIONFILTER(lResGr);
        lResGr.SETCURRENTKEY("No.");
        lResGrCount := lResGr.COUNT;
        IF lResGrCount > 0 THEN BEGIN
            lResGr.FIND('-');
            WHILE lResGrCount > 0 DO BEGIN
                lResGrCount := lResGrCount - 1;
                lResGr.MARKEDONLY(FALSE);
                lFirst := lResGr."No.";
                lLast := lFirst;
                lMore := (lResGrCount > 0);
                WHILE lMore DO
                    IF lResGr.NEXT = 0 THEN
                        lMore := FALSE
                    ELSE
                        IF NOT lResGr.MARK THEN
                            lMore := FALSE
                        ELSE BEGIN
                            lLast := lResGr."No.";
                            lResGrCount := lResGrCount - 1;
                            IF lResGrCount = 0 THEN
                                lMore := FALSE;
                        END;
                IF lSelectionFilter <> '' THEN
                    lSelectionFilter := lSelectionFilter + '|';
                IF lFirst = lLast THEN
                    lSelectionFilter := lSelectionFilter + lFirst
                ELSE
                    lSelectionFilter := lSelectionFilter + lFirst + '..' + lLast;
                IF lResGrCount > 0 THEN BEGIN
                    lResGr.MARKEDONLY(TRUE);
                    lResGr.NEXT;
                END;
            END;
        END;
        EXIT(lSelectionFilter);
        //PREPAIE//
    END;


    VAR
        gEditable: Boolean;
}

