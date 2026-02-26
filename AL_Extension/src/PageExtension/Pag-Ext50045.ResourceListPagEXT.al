PageExtension 50045 "Resource List_PagEXT" extends "Resource List"
{
    Editable = true;
    /*GL2024    SourceTableView=SORTING(Compteur)
                    WHERE("Tree Code"=FILTER(<>''));*/
    layout
    {
        modify(Control1)
        {
            Editable = false;
        }
        addafter(Name)
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = all;
            }
        }
        addafter("Gen. Prod. Posting Group")
        {
            field(Qualification; Rec.Qualification)
            {
                ApplicationArea = all;
            }
        }

        addafter(Control1)
        {
            //DYS page addon non migrer
            // part(PyramidSubform; 8003930)
            // {
            //     Caption = 'Tree Subform';
            //     SubPageView = SORTING(Type, Code)
            //                           WHERE(Type = FILTER(<> Item));
            // }
            // part(ExtendedSubform; 8003944)
            // {
            //     Caption = 'Resource List Extended Text'
            //     SubPageLink = "Table Name" = CONST(Resource),
            //                           "No." = FIELD("No."),
            //                           "Language Code" = CONST(),
            //                           "Text No." = CONST(1);
            // }
            //DYS
        }


        addbefore(Control1)
        {
            group(Filtres)
            {
                Caption = 'Filters';

                field(FiltreNom; wSearchNameFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Search Name';

                    trigger OnValidate()
                    begin
                        SetFilters;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field("Groupe ressources"; wResGroupFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Resource Group';
                    TableRelation = "Resource Group";

                    trigger OnValidate()
                    var
                        lGrRes: Record "Resource Group";
                    begin

                        rec.COPYFILTER(Type, lGrRes.Type);
                        IF ACTION::LookupOK = PAGE.RUNMODAL(PAGE::"Resource Groups", lGrRes) THEN BEGIN
                            wResGroupFilter := lGrRes."No.";
                            SetFilters;
                            CurrPage.UPDATE(FALSE);
                        END;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field("Code nature"; wGenProdPostGroupFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Gen. Posting Group';
                    TableRelation = "Gen. Product Posting Group";

                    trigger OnValidate()
                    begin
                        SetFilters;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field(Statut; wStatus)
                {
                    ApplicationArea = all;
                    Caption = 'Status';

                    trigger OnValidate()
                    begin
                        SetFilters;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field("wExtended[1]"; wExtended[1])
                {
                    ApplicationArea = all;
                    Caption = 'wExtended[1]';
                    ShowCaption = false;
                    Visible = false;
                }
                field("wExtended[2]"; wExtended[2])
                {
                    ApplicationArea = all;
                    Caption = 'wExtended[2]';
                    ShowCaption = false;
                    Visible = false;
                }
                field("wExtended[3]"; wExtended[3])
                {
                    ApplicationArea = all;
                    Caption = 'wExtended[3]';
                    ShowCaption = false;
                    Visible = false;
                }
            }

        }
    }
    actions
    {
        modify("Ledger E&ntries")
        {
            Visible = false;
        }

        /*DYS   addafter("Ledger E&ntries")
           {
               action("Job Ledger Entries")
               {
                   Caption = 'Job Ledger Entries';
                   ApplicationArea = all;
                   //DYS page addon non migrer
                   // RunObject = Page 8004162;
                   // RunPageView = SORTING(Type, "No.", "Posting Date", "Job No.", "Work Type Code") WHERE("Bal. Created Entry" = CONST(false));
                   // RunPageLink = Type = CONST(Resource),
                   //                   "No." = FIELD("No.");
               }
           }*/

        addafter("Units of Measure")
        {
            /*DYS  action("Interim Missions")
              {
                  Caption = 'Interim Missions';
                  ApplicationArea = all;
                  //DYS page addon non migrer
                  // RunObject = Page 8004020;
                  // RunPageLink = "Resource No." = FIELD("No.");
              }*/
            /*DYS  action("Resource Groups")
              {
                  Caption = 'Interim Missions';
                  ApplicationArea = all;
                  //DYS page addon non migrer
                  // RunObject = Page 8004033;
                  // RunPageLink = "Resource No." = FIELD("No.");
              }*/
            action("Description")
            {
                Caption = 'Description';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lDesc: Record "Description Line";
                begin
                    //DESCRIPTION
                    lDesc.ShowDescription(156, 0, rec."No.", 0);
                    //DESCRIPTION//
                end;

            }
        }
        addafter("Units of Measure_Promoted")
        {
            actionref("Description1"; "Description")
            {

            }
        }

        addafter(Prices)
        {
            // action("Line Discount")
            // {
            //     Caption = 'Line Discount';
            //     ApplicationArea = all;
            //     RunObject = Page 7004;
            //     RunPageView = SORTING(Type, Code);
            //     RunPageLink = Type = CONST(Resource),
            //                       Code = FIELD("No.");
            // }
        }

        addafter("Plan&ning")
        {
            /*DYS    action("Expand/Collapse All")
                {
                    Caption = 'Expand/Collapse All';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        //DYS page addon non migrer
                        //Currpage.PyramidSubform.page.InitTempTable;
                    end;
                }
                action("Expand/Collapse Branch")
                {
                    Caption = 'Expand/Collapse Branch';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        //DYS page addon non migrer
                        //CurrPAGE.PyramidSubform.PAGE.ToggleExpandCollapse(TRUE);
                    end;
                }*/
            /*  GL2024    action("Extended Text")
               {
                   Caption = 'Extended Text';
                   ApplicationArea = all;
                   trigger OnAction()
                   begin
                         wSwitchExtended;
                   end;
               }*/
        }
    }
    trigger OnOpenPage()
    VAR
        lPyramid: Record Tree;
    begin


        /*GL2024    SourceTableView=SORTING(Compteur)
                        WHERE(Tree Code=FILTER(<>''));*/


        // Rec.FilterGroup(0);
        // rec.SetCurrentKey(Compteur);
        // Rec.SetFilter("Tree Code", '<>%1', '');
        // Rec.FilterGroup(2);

        wStatusVisible := rec.GETFILTER(Status) <> '';
        IF wStatusVisible THEN
            wStatus := rec.GETRANGEMAX(Status) + 1
        ELSE
            StatusFilterVISIBLE := (FALSE);

        wResGroupFilter := rec.GETFILTER("Res. Group Filter");
        wResponsibleFilter := rec.GETFILTER("Responsible No.");
        IF (rec.GETFILTER(Type) = '') THEN
            rec.FILTERGROUP(2);
        wSearchNameFilter := rec.GETFILTER("Search Name");
        PyramidSubformVISIBLE := (FALSE);
        //GL2024  Currpage.ListeRes.XPOS(220);
        //#8134 Currpage.ListeRes.WIDTH(Currpage.ListeRes.WIDTH + 6380);
        //GL2024  Currpage.ListeRes.WIDTH(Currpage.ListeRes.WIDTH);
        //#8134//
        B1VISIBLE := (FALSE);
        B2VISIBLE := (FALSE);
        IF (rec.GETFILTER(Type) = '') OR NOT EVALUATE(lPyramid.Type, rec.GETFILTER(Type)) THEN
            rec.FILTERGROUP(3)
        ELSE BEGIN
            lPyramid.SETFILTER(Type, rec.GETFILTER(Type));
            IF NOT lPyramid.ISEMPTY THEN BEGIN
                PyramidSubformVISIBLE := (TRUE);
                //DYS page addon non migrer
                //Currpage.PyramidSubform.Page.SETTABLEVIEW(lPyramid);
                //GL2024  Currpage.ListeRes.XPOS(6600);
                B1VISIBLE := (TRUE);
                B2VISIBLE := (TRUE);
            END;
        END;

        //OUVRAGE    pour le afficher tout du planning
        IF rec.GETFILTER(Type) <> '' THEN BEGIN
            rec.FILTERGROUP(10);
            rec.SETFILTER(Type, rec.GETFILTER(Type));
            rec.FILTERGROUP(0);
        END;
        //OUVRAGE//
        rec.FILTERGROUP(0);

        wExtended[rec.Type + 1] := NOT wExtended[rec.Type + 1];
        //GL2024 wSwitchExtended;
        /* GL2024   IF NOT B1VISIBLE THEN BEGIN
               Currpage.btnExtended.XPOS := 220;
               Currpage.ExtendedSubform.XPOS := 220;
               Currpage.ExtendedSubform.WIDTH := Currpage.ListeRes.WIDTH;
           END;*/

    end;

    trigger OnAfterGetRecord()
    begin
        rec.SETCURRENTKEY(Compteur);
    end;


    trigger OnAfterGetCurrRecord()
    begin
        //DYS page addon non migrer
        // IF ((rec."Tree Code" <> Currpage.PyramidSubform.page.GetPyramid) OR (rec."Tree Code" = ''))
        //    AND Currpage.LOOKUPMODE THEN
        //     Currpage.PyramidSubform.Page.FindTree(rec."Tree Code", rec.Type);
    end;




    PROCEDURE SetFilters();
    BEGIN
        rec.SETRANGE("Tree Code");
        IF wSearchNameFilter = '' THEN BEGIN
            rec.SETCURRENTKEY("No.");
            rec.SETRANGE("Search Name")
        END ELSE BEGIN
            rec.SETCURRENTKEY("Search Name");
            //  SETFILTER("Search Name",'*' + wSearchNameFilter + '*');
            rec.SETFILTER("Search Name", wSearchNameFilter + '*');
        END;

        IF wResGroupFilter = '' THEN BEGIN
            rec.SETRANGE("Res. Group Filter");
            rec.SETRANGE("In Res. Group");
        END ELSE BEGIN
            rec.SETFILTER("Res. Group Filter", wResGroupFilter);
            rec.SETRANGE("In Res. Group", TRUE);
        END;

        IF wStatusVisible AND
           (wStatus <> wStatus::All)
        THEN
            rec.SETRANGE(Status, wStatus - 1)
        ELSE
            rec.SETRANGE(Status);

        IF wGenProdPostGroupFilter = '' THEN
            rec.SETRANGE("Gen. Prod. Posting Group")
        ELSE
            rec.SETFILTER("Gen. Prod. Posting Group", wGenProdPostGroupFilter);

        IF rec.FIND('-') THEN;
        wOkSetFilter := TRUE;
    END;

    PROCEDURE wPyramidRefresh();
    VAR
        lTree: Code[20];
    BEGIN
        //DYS page addon non migrer
        // lTree := Currpage.PyramidSubform.Page.GetPyramid;
        IF lTree <> '' THEN BEGIN
            rec.SETCURRENTKEY("Tree Code");
            IF STRLEN(rec."Tree Code") <= 19 THEN
                rec.SETFILTER("Tree Code", '%1|%2', lTree, lTree + ' *')
            ELSE
                rec.SETFILTER("Tree Code", '%1', lTree);
        END ELSE
            rec.SETRANGE("Tree Code", '');
    END;

    /*GL2024 PROCEDURE wSwitchExtended();
     BEGIN
         wExtended[rec.Type + 1] := NOT wExtended[rec.Type + 1];
         Currpage.ExtendedSubform.VISIBLE(wExtended[rec.Type + 1]);

         IF wExtended[rec.Type + 1] THEN
             Currpage.ListeRes.HEIGHT(Currpage.PyramidSubform.HEIGHT - Currpage.ExtendedSubform.HEIGHT - 110)
         ELSE
             Currpage.ListeRes.HEIGHT(Currpage.PyramidSubform.HEIGHT);
     END;*/

    PROCEDURE wSetSelectionFilter(VAR pRes: Record Resource);
    VAR
        lRes: Record Resource;
    BEGIN
        lRes.COPY(Rec);
        IF lRes.GETFILTER("Tree Code") <> '' THEN BEGIN
            lRes.SETCURRENTKEY("Tree Code");               //PERF
            lRes.SETRANGE("Tree Code");
        END;

        pRes.COPY(Rec);
        IF pRes.GETFILTER("Tree Code") <> '' THEN BEGIN
            pRes.SETCURRENTKEY("Tree Code");              //PERF
            pRes.SETRANGE("Tree Code");
        END;
        pRes.SETCURRENTKEY("No.");

        CurrPage.SETSELECTIONFILTER(lRes);
        lRes.SETCURRENTKEY("No.");                     //PERF
        IF lRes.FIND('-') THEN
            REPEAT
                IF pRes.GET(lRes."No.") THEN
                    pRes.MARK(TRUE);
            UNTIL lRes.NEXT = 0;
        pRes.MARKEDONLY(TRUE);
    END;

    PROCEDURE wSetSelection(VAR pRes: Record Resource);
    BEGIN
        //PREPAIE
        CurrPage.SETSELECTIONFILTER(pRes);
        //PREPAIE//
    END;

    PROCEDURE wGetSelectionFilter(): Code[80];
    VAR
        lRes: Record Resource;
        lFirst: Text[20];
        lLast: Text[20];
        lSelectionFilter: Code[80];
        lResCount: Integer;
        lMore: Boolean;
    BEGIN
        //PREPAIE
        CurrPage.SETSELECTIONFILTER(lRes);
        lRes.SETCURRENTKEY("No.");
        lResCount := lRes.COUNT;
        IF lResCount > 0 THEN BEGIN
            lRes.FIND('-');
            WHILE lResCount > 0 DO BEGIN
                lResCount := lResCount - 1;
                lRes.MARKEDONLY(FALSE);
                lFirst := lRes."No.";
                lLast := lFirst;
                lMore := (lResCount > 0);
                WHILE lMore DO
                    IF lRes.NEXT = 0 THEN
                        lMore := FALSE
                    ELSE
                        IF NOT lRes.MARK THEN
                            lMore := FALSE
                        ELSE BEGIN
                            lLast := lRes."No.";
                            lResCount := lResCount - 1;
                            IF lResCount = 0 THEN
                                lMore := FALSE;
                        END;
                IF lSelectionFilter <> '' THEN
                    lSelectionFilter := lSelectionFilter + '|';
                IF lFirst = lLast THEN
                    lSelectionFilter := lSelectionFilter + lFirst
                ELSE
                    lSelectionFilter := lSelectionFilter + lFirst + '..' + lLast;
                IF lResCount > 0 THEN BEGIN
                    lRes.MARKEDONLY(TRUE);
                    lRes.NEXT;
                END;
            END;
        END;
        EXIT(lSelectionFilter);
        //PREPAIE//
    END;

    VAR
        wResGroupFilter: Code[20];
        wSearchNameFilter: Text[30];
        wGenProdPostGroupFilter: Code[50];
        wResponsibleFilter: Code[20];
        wOkSetFilter: Boolean;
        wStatus: Option All,Internal,External,Generic;
        wStatusVisible: Boolean;
        wPrevCode: Code[20];
        wExtended: ARRAY[20] OF Boolean;
        tOther: Label 'Other';
        //GL2024
        B1VISIBLE: Boolean;
        B2VISIBLE: Boolean;
        PyramidSubformVISIBLE: Boolean;
        StatusFilterVISIBLE: Boolean;



}



