PageExtension 50081 "Work Types_PagEXT" extends "Work Types"
{
    layout
    {

        addafter(Description)
        {
            field("Increase %"; rec."Increase %")
            {
                ApplicationArea = all;
            }
            field(Reevaluated; rec.Reevaluated)
            {
                ApplicationArea = all;
            }
            field("Work Time Type"; rec."Work Time Type")
            {
                ApplicationArea = all;
            }
            field("Working Time On Order"; rec."Working Time On Order")
            {
                ApplicationArea = all;
            }
        }

        addafter("Unit of Measure Code")
        {
            field("Job Absence No."; rec."Job Absence No.")
            {
                ApplicationArea = all;
            }
            field(Monday; rec.Monday)
            {
                ApplicationArea = all;
            }
            field(Tuesday; rec.Tuesday)
            {
                ApplicationArea = all;
            }
            field(Wednesday; rec.Wednesday)
            {
                ApplicationArea = all;
            }
            field(Thursday; rec.Thursday)
            {
                ApplicationArea = all;
            }
            field(Friday; rec.Friday)
            {
                ApplicationArea = all;
            }
            field(Saturday; rec.Saturday)
            {
                ApplicationArea = all;
            }
            field(Sunday; rec.Sunday)
            {
                ApplicationArea = all;
            }
            field(Holiday; rec.Holiday)
            {
                ApplicationArea = all;
            }
            field("Quantity (Base) in Hours"; rec."Quantity (Base) in Hours")
            {
                ApplicationArea = all;
            }
            field("Planning Color"; rec."Planning Color")
            {
                ApplicationArea = all;

                trigger OnAssistEdit()
                var
                //DYS page addon non migrer
                //  lColorSelector: Page 8001405;
                begin
                    //DYS
                    // lColorSelector.SetColor(rec."Planning Color");
                    // IF lColorSelector.RUNMODAL = ACTION::OK THEN
                    //     rec."Planning Color" := lColorSelector.GetColor;
                end;
            }
        }

    }
    actions
    {
        addfirst(Creation)
        {
            group("Pri&x")
            {

                Caption = '&Prices';
                action("Coûts")
                {
                    ApplicationArea = all;
                    Caption = 'Costs';
                    RunObject = Page "Resource Costs";
                    RunPageLink = Type = CONST(All),
                                  "Work Type Code" = FIELD(Code);
                }
                action("Pri&x2")
                {
                    ApplicationArea = all;
                    Caption = 'Prices';
                    RunObject = Page "Resource Prices";
                    RunPageLink = Type = CONST(All),
                                  "Work Type Code" = FIELD(Code);
                }
            }
        }

    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var

    begin

        //POINTAGE
        EVALUATE(rec."Work Time Type", rec.GETFILTER("Work Time Type"));
        rec.Monday := TRUE;
        rec.Tuesday := TRUE;
        rec.Wednesday := TRUE;
        rec.Thursday := TRUE;
        rec.Friday := TRUE;
        //POINTAGE//
    end;


    procedure wSetSelection(var pWorkType: Record "Work Type")
    begin
        //PREPAIE
        CurrPage.SETSELECTIONFILTER(pWorkType);
        //PREPAIE//
    end;


    procedure wGetSelectionFilter(): Code[80]
    var
        lWorkType: Record "Work Type";
        lFirst: Text[20];
        lLast: Text[20];
        lSelectionFilter: Code[80];
        lWorkTypeCount: Integer;
        lMore: Boolean;
    begin
        //PREPAIE
        CurrPage.SETSELECTIONFILTER(lWorkType);
        lWorkType.SETCURRENTKEY(Code);
        lWorkTypeCount := lWorkType.COUNT;
        IF lWorkTypeCount > 0 THEN BEGIN
            lWorkType.FIND('-');
            WHILE lWorkTypeCount > 0 DO BEGIN
                lWorkTypeCount := lWorkTypeCount - 1;
                lWorkType.MARKEDONLY(FALSE);
                lFirst := lWorkType.Code;
                lLast := lFirst;
                lMore := (lWorkTypeCount > 0);
                WHILE lMore DO
                    IF lWorkType.NEXT = 0 THEN
                        lMore := FALSE
                    ELSE
                        IF NOT lWorkType.MARK THEN
                            lMore := FALSE
                        ELSE BEGIN
                            lLast := lWorkType.Code;
                            lWorkTypeCount := lWorkTypeCount - 1;
                            IF lWorkTypeCount = 0 THEN
                                lMore := FALSE;
                        END;
                IF lSelectionFilter <> '' THEN
                    lSelectionFilter := lSelectionFilter + '|';
                IF lFirst = lLast THEN
                    lSelectionFilter := lSelectionFilter + lFirst
                ELSE
                    lSelectionFilter := lSelectionFilter + lFirst + '..' + lLast;
                IF lWorkTypeCount > 0 THEN BEGIN
                    lWorkType.MARKEDONLY(TRUE);
                    lWorkType.NEXT;
                END;
            END;
        END;
        EXIT(lSelectionFilter);
        //PREPAIE//
    end;
}


