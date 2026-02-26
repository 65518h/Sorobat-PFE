Page 58003 "RTC Resource Planning Matrix"
{
    // #8433 XPE 05/11/2010 Modification de la fonction MatrixOnDrillDown
    // #8433 XPE 05/11/2010 Appelle du formulaire detail planning en RunModal
    // #8433 XPE 05/11/2010 Appelle de la fonction fRefreshData
    // #8225 AC 15/09/10
    // //PLANNING_TASK CW 19/08/09 replace SalesPlanningLine by PlanningLine + SetJobTask
    // //PLANNING GESWAY 12/02/04 Planning ressource
    //                            Attention Astuce pour garder la valeur de wPerDate : Ajout en visible NO d'un champ Boolean pour wPerDate
    // //OUVRAGE GESWAY 22/04/05 Avoir la fiche qui correspond au type
    // //CAPACITE AC 02/05/06 Ajout dans DrillDown Lien avec le formulaire 224 si type d'affichage = capacité.
    // //+JOB+ CLA 23/10/07 Renseignement "Job Task No."

    Caption = 'RTC Resource Planning Matrix';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = 156;
    SourceTableView = where(Type = filter(Person | Machine),
                            Blocked = const(false));

    layout
    {
        area(content)
        {
            group(Afichage)
            {
                Caption = 'Afichage';
                group(Control800390000)
                {
                    Caption = 'Afichage';
                    field(ShowOption; ShowOption)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show';
                        //DecimalPlaces = 0 : 2;
                        OptionCaption = 'Work Load (h),Description,,,Job Name,Job No.,Count,Capacity,Availability,Load %';

                        trigger OnValidate()
                        begin
                            if ShowOption = Showoption::Availability then begin
                                RecFilters.CopyFilters(Rec);
                            end else if xShowOption = Showoption::Availability then
                                    rec.CopyFilters(RecFilters);
                            xShowOption := ShowOption;
                            fRefreshData();
                            ShowOptionOnAfterValidate;
                        end;
                    }
                    field(gShowHistory; gShowHistory)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show History';

                        trigger OnValidate()
                        begin
                            gShowHistoryOnAfterValidate;
                        end;
                    }
                    field(HighLightJob; HighLightJob)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Highlight Job';
                        TableRelation = Job;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            lJob: Record job;
                        begin
                            if lJob.Get(HighLightJob) then;
                            if page.RunModal(0, lJob) = Action::LookupOK then begin
                                HighLightJob := lJob."No.";
                                CurrPage.Update(false);
                            end;
                        end;

                        trigger OnValidate()
                        var
                            lPlanning: Record 8004130;
                        begin
                            lPlanning.SetFilter("Job No.", HighLightJob);
                            fRefreshData();
                        end;
                    }
                    field(HighLightProdPostingGroup; HighLightProdPostingGroup)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Highlight Prod. Posting Group';
                        TableRelation = "Gen. Product Posting Group";

                        trigger OnValidate()
                        var
                            lPlanning: Record 8004130;
                        begin
                            lPlanning.SetFilter("Prod. Posting Group", HighLightProdPostingGroup);
                            fRefreshData();
                            HighLightProdPostingGroupOnAft;
                        end;
                    }
                    field(HighLightQuantity; HighLightQuantity)
                    {
                        ApplicationArea = Basic;
                        Caption = 'HighLight Quantity';

                        trigger OnValidate()
                        var
                            lPlanning: Record 8004130;
                        begin
                            lPlanning.SetFilter(Quantity, HighLightQuantity);
                            fRefreshData();
                        end;
                    }
                }
                group(Affectation)
                {
                    Caption = 'Affectation';
                    field("Default.""Planning Task No."""; Default."Planning Task No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Planning Task';
                        TableRelation = "Planning Line"."Task No.";

                        trigger OnValidate()
                        begin
                            Default.Validate(Default."Planning Task No.");
                            DefaultPlanningTaskNoOnAfterVa;
                        end;
                    }
                    field("Default.""Job No."""; Default."Job No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Job No.';
                        TableRelation = Job;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            lJob: Record job;
                        begin
                            /*
                            //#5898
                            IF lJob.GET(Default."Job No.") THEN;
                            CLEAR(JobListSimplified);
                            JobListSimplified.wSetJob(Text,FALSE);
                            JobListSimplified.UPDATECONTROLS;
                            IF JobListSimplified.RUNMODAL = ACTION::OK THEN BEGIN
                              JobListSimplified.GETRECORD(lJob);
                              Default."Job No." := lJob."No.";
                              CurrForm.UPDATE(FALSE);
                            END;
                            //#5898//
                            */
                            if lJob.Get(Default."Job No.") then;
                            if page.RunModal(0, lJob) = Action::LookupOK then begin
                                Default."Job No." := lJob."No.";
                                Default.Description := lJob.Description;
                                CurrPage.Update(false);
                            end;

                        end;

                        trigger OnValidate()
                        var
                            lJob: Record job;
                        begin
                            if lJob.Get(Default."Job No.") then
                                Default.Description := lJob."Description 2";
                        end;
                    }
                    field("Default.Description"; Default.Description)
                    {
                        ApplicationArea = Basic;
                        //BlankZero = true;
                        Caption = 'Description';
                        //DecimalPlaces = 0 : 2;
                    }
                    field("Default.""Resource Group No."""; Default."Resource Group No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Resource Group No.';
                        TableRelation = "Resource Group";
                    }
                    field("Default.Quantity"; Default.Quantity)
                    {
                        ApplicationArea = Basic;
                        //BlankZero = true;
                        Caption = 'Quantity';
                        //DecimalPlaces = 0 : 2;
                    }
                }
            }
            group(Options)
            {
                Caption = 'Options';
                field(wPerDate; wPerDate)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                group("Resource Filters")
                {
                    Caption = 'Resource Filters';
                    field(ForRefresh; ResourceTypeFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Resource Type';
                        //DecimalPlaces = 0 : 2;
                        OptionCaption = ' ,Person,Machine';

                        trigger OnValidate()
                        begin
                            SetFilters;
                            if wPerDate then;
                            fRefreshData();
                            ResourceTypeFilterOnAfterValid;
                        end;
                    }
                    field(Statut; ResourceStatusFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Status';
                        //DecimalPlaces = 0 : 2;
                        OptionCaption = ' ,Internal,External,Generic';
                        Visible = false;

                        trigger OnValidate()
                        begin
                            SetFilters;
                            fRefreshData();
                            ResourceStatusFilterOnAfterVal;
                        end;
                    }
                    field(ResProdPostGroupFilter; ResProdPostGroupFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Prod. Posting Group';

                        trigger OnValidate()
                        begin
                            SetFilters;
                            fRefreshData();
                            ResProdPostGroupFilterOnAfterV;
                        end;
                    }
                    field("Res. Group Filter"; Rec."Res. Group Filter")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            SetFilters;
                            fRefreshData();
                            ResGroupFilterOnAfterValidate;
                        end;
                    }
                }
                group("Matrix Options")
                {
                    Caption = 'Matrix Options';
                    field(PeriodType; PeriodType)
                    {
                        ApplicationArea = Basic;
                        Caption = 'View by';
                        OptionCaption = 'Day,Week,Month,Quarter,Year';

                        trigger OnValidate()
                        begin
                            SetColumns(Matrix_setwanted::Initial);
                            fRefreshData();
                        end;
                    }
                    field(MATRIX_CaptionRange; MATRIX_CaptionRange)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Column Set';
                        Editable = false;
                    }
                    field(QtyType; QtyType)
                    {
                        ApplicationArea = Basic;
                        Caption = 'View as';
                        OptionCaption = 'Net Change,Balance at Date';

                        trigger OnValidate()
                        begin
                            fRefreshData();
                        end;
                    }
                }
            }
            repeater(Matrix)
            {
                ShowCaption = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsible No."; rec."Responsible No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = "Responsible No.Visible";
                }
                field("Resource Group No."; rec."Resource Group No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = "Resource Group No.Visible";
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(1);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(1);
                        MATRIXCellData1OnAfterValidate;
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(2);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(2);
                        MATRIXCellData2OnAfterValidate;
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(3);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(3);
                        MATRIXCellData3OnAfterValidate;
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(4);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(4);
                        MATRIXCellData4OnAfterValidate;
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(5);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(5);
                        MATRIXCellData5OnAfterValidate;
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[6];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(6);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(6);
                        MATRIXCellData6OnAfterValidate;
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[7];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(7);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(7);
                        MATRIXCellData7OnAfterValidate;
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[8];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(8);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(8);
                        MATRIXCellData8OnAfterValidate;
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[9];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(9);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(9);
                        MATRIXCellData9OnAfterValidate;
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[10];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(10);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(10);
                        MATRIXCellData10OnAfterValidat;
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[11];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(11);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(11);
                        MATRIXCellData11OnAfterValidat;
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[12];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(12);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(12);
                        MATRIXCellData12OnAfterValidat;
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[13];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(13);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(13);
                        MATRIXCellData13OnAfterValidat;
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[14];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(14);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(14);
                        MATRIXCellData14OnAfterValidat;
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[15];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(15);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(15);
                        MATRIXCellData15OnAfterValidat;
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[16];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(16);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(16);
                        MATRIXCellData16OnAfterValidat;
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[17];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(17);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(17);
                        MATRIXCellData17OnAfterValidat;
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[18];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(18);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(18);
                        MATRIXCellData18OnAfterValidat;
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[19];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(19);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(19);
                        MATRIXCellData19OnAfterValidat;
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[20];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(20);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(20);
                        MATRIXCellData20OnAfterValidat;
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[21];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(21);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(21);
                        MATRIXCellData21OnAfterValidat;
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[22];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(22);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(22);
                        MATRIXCellData22OnAfterValidat;
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[23];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(23);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(23);
                        MATRIXCellData23OnAfterValidat;
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[24];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(24);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[25];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(25);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(25);
                        MATRIXCellData25OnAfterValidat;
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[26];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(26);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(26);
                        MATRIXCellData26OnAfterValidat;
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[27];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(27);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(27);
                        MATRIXCellData27OnAfterValidat;
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[28];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(28);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(28);
                        MATRIXCellData28OnAfterValidat;
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[29];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(29);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(29);
                        MATRIXCellData29OnAfterValidat;
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[30];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(30);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(30);
                        MATRIXCellData30OnAfterValidat;
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[31];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(31);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(31);
                        MATRIXCellData31OnAfterValidat;
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MATRIX_CaptionSet[32];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(32);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(32);
                        MATRIXCellData32OnAfterValidat;
                    end;
                }
            }

            field(HidePrivate; HidePrivate)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("&Resource1")
            {
                Caption = '&Resource';
                actionref(Card1; Card) { }
                actionref(Statistics1; Statistics) { }
                actionref("Co&mments1"; "Co&mments") { }
                actionref(Dimensions1; Dimensions) { }
            }

            group("Plan&ning1")
            {
                Caption = 'Plan&ning';
                actionref(Allocate11; Allocate1) { }
                actionref(Delete1; Delete) { }
                actionref(Cut1; Cut) { }
                actionref("Copy (&C)1"; "Copy (&C)") { }
                actionref(Paste11; Paste1) { }
                actionref("&Allocate1"; "&Allocate") { }
            }

            actionref("Hide/Show Private1"; "Hide/Show Private") { }
            actionref("Per Date1"; "Per Date") { }

            actionref("Previous Set1"; "Previous Set") { }
            actionref("Previous Column1"; "Previous Column") { }
            actionref("Next Column1"; "Next Column") { }
            actionref("Next Set1"; "Next Set") { }

        }
        area(navigation)
        {
            group("&Resource")
            {
                Caption = '&Resource';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;

                    trigger OnAction()
                    begin
                        case rec.Type of
                            rec.Type::Person:
                                page.RunModal(page::"Resource Card", Rec);
                            rec.Type::Machine:
                                page.RunModal(page::"Resource Card", Rec);
                            //  Type::Expense: page.RunModal(page::Form8004071,Rec);
                            else
                                ;
                        end;
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;

                    RunpageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter");
                    RunObject = Page "Resource Statistics";
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunpageLink = "Table Name" = CONST(Resource),
                                  Code = FIELD("No.");
                    RunObject = Page "Comment Sheet";
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunpageLink = "Table ID" = CONST(156),
                                  "No." = FIELD("No.");
                    RunObject = Page "Default Dimensions";
                }
                /*GL2024   action("Ledger E&ntries")
                   {
                       ApplicationArea = Basic;
                       Caption = 'Ledger E&ntries';
                       RunpageLink = "No."=FIELD("No.");
                       RunpageView = SORTING(Job No.,Entry Type,Type,No.,Planning Task No.,Posting Date)
                                     WHERE(Type=CONST(Resource));
                       RunObject = Page 8004162;
                   }
                   action("Ecritures planning")
                   {
                       ApplicationArea = Basic;
                       Caption = 'Ecritures planning';
                       RunpageLink = "No."=FIELD("No.");
                       RunObject = Page 8004130;
                   }
                   action(Availability)
                   {
                       ApplicationArea = Basic;
                       Caption = 'Availability';
                       RunpageLink = "No."=FIELD("No.");
                       RunObject = Page 8004171;
                   }
                   action("Resource Groups")
                   {
                       ApplicationArea = Basic;
                       Caption = 'Resource Groups';
                       RunpageLink = Resource "No."=FIELD("No.");
                       RunObject = Page 8004033;
                   }*/
            }
            group("Plan&ning")
            {
                Caption = 'Plan&ning';
                action(Allocate1)
                {
                    ApplicationArea = Basic;
                    Caption = 'Allocate';

                    trigger OnAction()
                    begin
                        if (gCellActive <= 0) and (gCellActive > MATRIX_CurrSetLength) then
                            exit;
                        Paste(gCellActive, Default);
                    end;
                }
                action(Delete)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delete';

                    trigger OnAction()
                    var
                        lPlanning: Record 8004130;
                    begin
                        if (gCellActive <= 0) and (gCellActive > MATRIX_CurrSetLength) then
                            exit;

                        SetPlanningCellFilters_MATRIX(gCellActive, lPlanning, Rec);
                        if (lPlanning.Count <> 1) then
                            Error(tMustBeUnique, lPlanning.TableCaption);
                        lPlanning.Find('-');
                        lPlanning.Delete(true);
                    end;
                }
                action(Cut)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cut';

                    trigger OnAction()
                    var
                        lPlanning: Record 8004130;
                        lPanResVisible: Boolean;
                    begin
                        if (gCellActive <= 0) and (gCellActive > MATRIX_CurrSetLength) then
                            exit;
                        SetPlanningCellFilters_MATRIX(gCellActive, lPlanning, Rec);

                        if (lPlanning.Count <> 1) and (bMatrixActived) then begin
                            HoldPlanning.DeleteAll;
                            Commit;
                            Error(tMustBeUnique, lPlanning.TableCaption);
                        end;

                        HoldPlanning.DeleteAll;
                        lPlanning.Find('-');
                        repeat
                            HoldPlanning.TransferFields(lPlanning);
                            HoldPlanning.Status := 0;
                            HoldPlanning.Insert;
                        until lPlanning.Next = 0;
                        Cut := true;
                    end;
                }
                action("Copy (&C)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy (&C)';

                    trigger OnAction()
                    var
                        lPlanning: Record 8004130;
                        lPanResVisible: Boolean;
                    begin
                        SetPlanningCellFilters_MATRIX(gCellActive, lPlanning, Rec);

                        if (lPlanning.Count <> 1) and (bMatrixActived) then begin
                            HoldPlanning.DeleteAll;
                            Commit;
                            Error(tMustBeUnique, lPlanning.TableCaption);
                        end;

                        HoldPlanning.DeleteAll;
                        lPlanning.Find('-');
                        repeat
                            HoldPlanning.TransferFields(lPlanning);
                            HoldPlanning.Status := 0;
                            HoldPlanning.Insert;
                        until lPlanning.Next = 0;

                        Cut := false;
                    end;
                }
                action(Paste1)
                {
                    ApplicationArea = Basic;
                    Caption = 'Paste';

                    trigger OnAction()
                    var
                        lPlanning: Record 8004130;
                    begin
                        if (gCellActive <= 0) and (gCellActive > MATRIX_CurrSetLength) then
                            exit;

                        if not HoldPlanning.IsEmpty then begin
                            HoldPlanning.Find('-');
                            repeat
                                Paste(gCellActive, HoldPlanning);
                                //    IF INSERT THEN ;
                                if Cut then begin
                                    lPlanning.Get(HoldPlanning."Entry No.");
                                    lPlanning.Delete(true)
                                end;
                            until HoldPlanning.Next = 0;
                            if Cut then begin
                                Cut := false;
                                HoldPlanning.DeleteAll;
                            end;
                        end;
                    end;
                }
                action("&Allocate")
                {
                    ApplicationArea = Basic;
                    Caption = '&Allocate';

                    trigger OnAction()
                    begin
                        if (gCellActive <= 0) and (gCellActive > MATRIX_CurrSetLength) then
                            exit;

                        Allocate(gCellActive);
                    end;
                }
            }
        }
        area(processing)
        {
            action("Hide/Show Private")
            {
                ApplicationArea = Basic;
                Caption = 'Hide/Show Private';

                ToolTip = 'Hide/Show Private';

                trigger OnAction()
                begin
                    HidePrivate := not HidePrivate;
                end;
            }
            action("Per Date")
            {
                ApplicationArea = Basic;
                Caption = 'Per Date';

                ToolTip = 'Per Date';

                trigger OnAction()
                begin
                    wPerDate := not wPerDate;
                    //#3454
                    ValidateColumnDimCode;
                    ValidateLineDimCode;
                    SetFilters;
                    //#3454//

                    "Responsible No.Visible" := wPerDate;
                    "Resource Group No.Visible" := wPerDate;
                    //CurrForm."Gen. Prod. Posting Group".VISIBLE(wPerDate);
                    if not wPerDate then begin
                        CurrentRes.Copy(MatrixRecord);
                        CurrentDate.Copy(Rec);
                        MatrixRecord.Copy(CurrentDate);
                        rec.Copy(CurrentRes);
                    end else begin
                        CurrentDate.Copy(MatrixRecord);
                        CurrentRes.SetView(Rec.GetView);
                        rec.Copy(CurrentDate);
                        MatrixRecord.Copy(CurrentRes);
                    end;

                    SetColumns(Matrix_setwanted::Initial);
                    fRefreshData();
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                /*  //GL2024     action(Print)
                   {
                       ApplicationArea = Basic;
                       Caption = 'Print';
                       Ellipsis = true;
                       Image = Print;
                       RunObject = Report 8004132;
               action("Capacity Update")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Capacity Update';
                        RunpageOnRec = true;

                        trigger OnAction()
                        var
                            lRec: Record 156;
                         //GL2024   lCapacityUpdate: Report 8004134;
                        begin
                            lRec.Copy(Rec);
                            lRec.SetRange("Date Filter");
                            lCapacityUpdate.SetTableview(lRec);
                            lCapacityUpdate.RunModal;
                        end;
                    }
                    action("Replace resource")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Replace resource';

                        trigger OnAction()
                        var
                            lRec: Record 156;
                            lReplaceResource: Report 8004133;
                        begin
                            lRec.SetRange("No.", rec."No.");
                            lRec.SetRange(Name, rec.Name);

                            lReplaceResource.SetTableview(lRec);
                            lReplaceResource.RunModal;
                        end;
                    }
                    action("P&ost")
                    {
                        ApplicationArea = Basic;
                        Caption = 'P&ost';
                        Image = Post;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;

                        trigger OnAction()
                        var
                            lPlanningPosting: Report 8004130;
                        begin
                            lPlanningPosting.RunModal;
                            CurrPage.Update;
                        end;
                    }*/
            }
            action("Previous Set")
            {
                ApplicationArea = Basic;
                Caption = 'Previous Set';
                Image = PreviousSet;

                ToolTip = 'Previous Set';

                trigger OnAction()
                var
                    MATRIX_Step: Option Initial,Previous,Same,Next;
                begin
                    SetColumns(Matrix_setwanted::Previous);
                    fRefreshData();
                end;
            }
            action("Previous Column")
            {
                ApplicationArea = Basic;
                Caption = 'Previous Column';
                Image = PreviousRecord;

                ToolTip = 'Previous Column';

                trigger OnAction()
                var
                    MATRIX_Step: Option Initial,Previous,Same,Next;
                begin
                    SetColumns(Matrix_setwanted::PreviousColumn);
                    fRefreshData();
                end;
            }
            action("Next Column")
            {
                ApplicationArea = Basic;
                Caption = 'Next Column';
                Image = NextRecord;

                ToolTip = 'Next Column';

                trigger OnAction()
                var
                    MATRIX_Step: Option Initial,Previous,Same,Next;
                begin
                    SetColumns(Matrix_setwanted::NextColumn);
                    fRefreshData();
                end;
            }
            action("Next Set")
            {
                ApplicationArea = Basic;
                Caption = 'Next Set';
                Image = NextSet;

                ToolTip = 'Next Set';

                trigger OnAction()
                var
                    MATRIX_Step: Option Initial,Previous,Same,Next;
                begin
                    SetColumns(Matrix_setwanted::Next);
                    fRefreshData();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        fRefreshData();
        NoOnFormat;
        NameOnFormat;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(FindRec(LineDimOption, Rec, Which));
    end;

    trigger OnInit()
    begin
        "Resource Group No.Visible" := true;
        "Responsible No.Visible" := true;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        exit(NextRec(LineDimOption, Rec, Steps));
    end;

    trigger OnOpenPage()
    var
        lIndex: Integer;
    begin
        fInitialise();
        SetColumns(Matrix_setwanted::Initial);
    end;

    var
        Default: Record 8004130 temporary;
        HoldPlanning: Record 8004130 temporary;
        RecFilters: Record 156;
        PeriodFormMgt: Codeunit PeriodPageManagement;
        PlanningMgt: Codeunit 8004130;
        CalendarMgt: Codeunit 7600;
        PeriodType: Option Day,Week,Month,Quarter,Year;
        QtyType: Option "Net Change","Balance at Date";
        CellText: Text[250];
        HidePrivate: Boolean;
        ShowOption: Option Quantity,Description,"Resource Name","Resource No.","Job Name","Job No.","Count",Capacity,Availability,"Load %";
        tPeriodType: label 'Show mode must be in day period.';
        tMustBeUnique: label '%1 must be alone.';
        xShowOption: Integer;
        HighLightQuantity: Text[30];
        HighLightJob: Text[30];
        HighLightProdPostingGroup: Text[30];
        Cut: Boolean;
        tFilterDisable: label 'Filtrers disable with current show option';
        tSyntaxError: label 'Syntax error';
        tDisableForShowOption: label 'Not enable for this showoption %1';
        LineDimOption: Boolean;
        ColumnDimOption: Boolean;
        CurrentDate: Record 156;
        CurrentRes: Record 156;
        MatrixHeader: Text[50];
        KOClose: Boolean;
        bMatrixActived: Boolean;
        bPanelActived: Boolean;
        wJobFilter: Text[50];
        wProdPostGrpFilter: Text[50];
        ResourceTypeFilter: Option " ",Person,Machine;
        ResourceStatusFilter: Option " ",Internal,External,Generic;
        ResProdPostGroupFilter: Text[80];
        wPerDate: Boolean;
        gShowHistory: Boolean;
        "-------": Integer;
        MATRIX_SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[100];
        MATRIX_CurrSetLength: Integer;
        MATRIX_CellData: array[32] of Text[1024];
        MATRIX_ForeColor: array[32] of Integer;
        MATRIX_FontBold: array[32] of Boolean;
        MATRIX_FontSelected: array[32] of Boolean;
        gMatrixPeriods: array[32] of Record Date;
        MatrixRecord: Record 156;
        MatrixRecords: array[32] of Record 156;
        MatrixRecordRef: RecordRef;
        gCellActive: Integer;
        gDateFilter: Text[1024];
        [InDataSet]
        "Responsible No.Visible": Boolean;
        [InDataSet]
        "Resource Group No.Visible": Boolean;


    procedure SetColumns(pPeriodType: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit "Matrix Management";
        DateFilter: Text[30];
        lIndex: Integer;
        CaptionFieldNo: Integer;
    begin
        if (not wPerDate) then begin

            MatrixMgt.GeneratePeriodMatrixData(pPeriodType, ArrayLen(MATRIX_CellData), false, PeriodType, gDateFilter,
              MATRIX_PKFirstRecInCurrSet, MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrSetLength, gMatrixPeriods);
            for lIndex := 1 to MATRIX_CurrSetLength do begin
                fFormatCaption(MATRIX_CaptionSet[lIndex], gMatrixPeriods[lIndex]);
                //SetFilterSubForm(lIndex);
            end;
        end else begin
            Clear(MATRIX_CaptionSet);
            Clear(MatrixRecords);

            MatrixRecordRef.GetTable(MatrixRecord);
            MatrixRecordRef.SetTable(MatrixRecord);

            CaptionFieldNo := MatrixRecord.FieldNo("No.");

            MatrixMgt.GenerateMatrixData(MatrixRecordRef, pPeriodType, ArrayLen(MatrixRecords), CaptionFieldNo, MATRIX_PKFirstRecInCurrSet,
              MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrSetLength);

            if MATRIX_CurrSetLength > 0 then begin
                lIndex := 1;
                MatrixRecord.SetPosition(MATRIX_PKFirstRecInCurrSet);
                MatrixRecord.Find;
                repeat
                    MatrixRecords[lIndex].Copy(MatrixRecord);
                    MATRIX_CaptionSet[lIndex] := MatrixRecords[lIndex].Name + ' ' + MatrixRecords[lIndex]."No.";
                    //SetFilterSubForm(lIndex);
                    lIndex += +1;
                until (lIndex > MATRIX_CurrSetLength) or (MatrixRecord.Next <> 1);
            end;
        end;
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    begin
        SetDateFilter(ColumnID);
        if not wPerDate then
            REC.CalcFields("Period Planning Quantity", Capacity, "Res. Posted Quantity (Base)")
        else
            MatrixRecords[ColumnID].CalcFields("Period Planning Quantity", Capacity, "Res. Posted Quantity (Base)");

        MATRIX_CellData[ColumnID] := fSetValue(ColumnID, MATRIX_ForeColor[ColumnID], MATRIX_FontBold[ColumnID], MATRIX_FontSelected[ColumnID]
        );
    end;


    procedure fFormatCaption(var pCaption: Text[255]; var pDate: Record Date)
    var
        lForeColor: Integer;
    begin
        if PeriodType = Periodtype::Day then begin
            PlanningMgt.DateTitle(pDate, pCaption, lForeColor);
            if lForeColor <> 0 then begin
                pDate.Mark(true);
            end;
        end;
    end;


    procedure fSetValue(pColumnID: Integer; var pForeColor: Integer; var pFontBold: Boolean; var pFontSelected: Boolean) Return: Text[255]
    var
        lPlanning: Record 8004130;
        lResLedgEntry: Record 203;
        lTemporary: Record 8004130 temporary;
        lDecimal: Decimal;
        lOK: Boolean;
        lQty: Decimal;
    begin
        if wPerDate then begin
            if gShowHistory then
                MatrixRecords[pColumnID].CalcFields("Period Planning Quantity", Capacity, "Res. Posted Quantity (Base)")
            else
                MatrixRecords[pColumnID].CalcFields("Period Planning Quantity", Capacity);
            lQty := MatrixRecords[pColumnID]."Period Planning Quantity" + MatrixRecords[pColumnID]."Res. Posted Quantity (Base)";
            rec.Capacity := MatrixRecords[pColumnID].Capacity;
        end else begin
            if gShowHistory then
                rec.CalcFields("Period Planning Quantity", Capacity, "Res. Posted Quantity (Base)")
            else
                rec.CalcFields("Period Planning Quantity", Capacity);
            lQty := rec."Period Planning Quantity" + rec."Res. Posted Quantity (Base)";
            rec.Capacity := rec.Capacity;
        end;

        SetHistoryCellFilters_MATRIX(pColumnID, lResLedgEntry, Rec);
        //IF (PeriodType <> PeriodType::Day) OR
        if (ShowOption in [Showoption::Quantity, Showoption::Capacity, Showoption::Availability, Showoption::"Load %"]) then begin
            Return := '';
            case ShowOption of
                Showoption::Quantity:
                    lDecimal := lQty;
                Showoption::Capacity:
                    lDecimal := rec.Capacity;
                Showoption::Availability:
                    lDecimal := rec.Capacity - lQty;
                Showoption::"Load %":
                    if rec.Capacity <> 0 then
                        lDecimal := ROUND(lQty / rec.Capacity * 100, 0.1)
                    else if lQty <> 0 then
                        Return := Format(lQty) + '/0'
            end;
            if lDecimal <> 0 then
                if ShowOption = Showoption::"Load %" then
                    Return := Format(lDecimal) + '%'
                //#6095
                //    ELSE IF PeriodType <> PeriodType::Day THEN
                //      Text := FORMAT(lDecimal,0,'<Precision,0:0><Standard Format,0>')
                //#6095//
                else
                    Return := Format(lDecimal);
            if (HighLightQuantity <> '') and (Return <> '') then begin
                lTemporary.Quantity := lDecimal;
                lTemporary.Insert;
                lTemporary.SetFilter(Quantity, HighLightQuantity);
            end;
        end else begin
            SetHistoryCellFilters_MATRIX(pColumnID, lResLedgEntry, Rec);
            SetPlanningCellFilters_MATRIX(pColumnID, lPlanning, Rec);

            if HidePrivate then
                lPlanning.SetRange(Private, false)
            else
                lPlanning.SetRange(Private);

            if lPlanning.IsEmpty and not gShowHistory then begin
            end

            else if ShowOption = Showoption::Count then begin
                if gShowHistory then
                    lQty := lPlanning.Count + lResLedgEntry.Count
                else
                    lQty := lPlanning.Count;
                if lQty <> 0 then
                    Return := Format(lQty);
            end else
                //#8225
                Return := PlanningMgt.Description(lPlanning, lResLedgEntry, ShowOption, pForeColor, pFontBold, gShowHistory);
            //#8225//
        end;

        if (Return <> '') and ((HighLightJob <> '') or (HighLightProdPostingGroup <> '') or (HighLightQuantity <> '')) then begin
            SetPlanningCellFilters_MATRIX(pColumnID, lPlanning, Rec);
            if HighLightJob <> '' then begin
                lPlanning.SetFilter("Job No.", HighLightJob);
                lResLedgEntry.SetFilter("Job No.", HighLightJob);
            end;
            if HighLightProdPostingGroup <> '' then begin
                lPlanning.SetFilter("Prod. Posting Group", HighLightProdPostingGroup);
                lResLedgEntry.SetFilter("Gen. Prod. Posting Group", HighLightProdPostingGroup);
            end;
            lOK := true;
            if (HighLightQuantity <> '') and (lDecimal <> 0) then
                lOK := not lTemporary.IsEmpty;

            if gShowHistory then
                pFontSelected := ((not lPlanning.IsEmpty or not lResLedgEntry.IsEmpty) and lOK)
            else
                pFontSelected := (not lPlanning.IsEmpty and lOK);
        end;

        if (Return = '') and MatrixRecords[pColumnID].Mark then
            Return := '-----';
    end;

    local procedure SetDateFilter(pColumnID: Integer)
    begin
        if not wPerDate then begin
            if QtyType = Qtytype::"Net Change" then
                if gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End" then
                    rec.SetRange("Date Filter", gMatrixPeriods[pColumnID]."Period Start")
                else
                    rec.SetRange("Date Filter", gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End")
            else
                rec.SetRange("Date Filter", 0D, gMatrixPeriods[pColumnID]."Period End");
        end else begin
            if QtyType = Qtytype::"Net Change" then begin
                if rec."Employment Date" = rec."Last Date Modified" then
                    MatrixRecords[pColumnID].SetRange("Date Filter", rec."Employment Date")
                else
                    MatrixRecords[pColumnID].SetRange("Date Filter", rec."Employment Date", rec."Last Date Modified");
            end else
                MatrixRecords[pColumnID].SetRange("Date Filter", 0D, rec."Last Date Modified");
        end;
    end;


    procedure SetPlanningCellFilters_MATRIX(pColumnID: Integer; var pPlanning: Record 8004130; pRes: Record 156)
    begin
        if not wPerDate then begin
            pPlanning.SetCurrentkey(Type, "No.", Date, "Start Time");
            pPlanning.SetRange(Type, pRes.Type);
            pPlanning.SetRange("No.", pRes."No.");
            if gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End" then
                pPlanning.SetRange(Date, gMatrixPeriods[pColumnID]."Period Start")
            else
                pPlanning.SetRange(Date, gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End");
        end else begin
            pPlanning.SetCurrentkey(Type, "No.", Date, "Start Time");
            pPlanning.SetRange(Type, MatrixRecords[pColumnID].Type);
            pPlanning.SetRange("No.", MatrixRecords[pColumnID]."No.");
            if pRes."Employment Date" = pRes."Last Date Modified" then
                pPlanning.SetRange(Date, pRes."Employment Date")
            else
                pPlanning.SetRange(Date, pRes."Employment Date", pRes."Last Date Modified");
        end;
    end;


    procedure SetHistoryCellFilters_MATRIX(pColumnID: Integer; var pResLedgEntry: Record 203; pRes: Record 156)
    begin
        if not gShowHistory then
            exit;
        pResLedgEntry.SetCurrentkey("Entry Type", "Planning Source", Chargeable, "Unit of Measure Code",
                               "Resource Group No.", "Resource No.", "Planning Task No.", "Posting Date");
        if not wPerDate then begin
            pResLedgEntry.SetRange("Planning Source", true);
            pResLedgEntry.SetRange("Resource No.", pRes."No.");
            if gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End" then
                pResLedgEntry.SetRange("Posting Date", gMatrixPeriods[pColumnID]."Period Start")
            else
                pResLedgEntry.SetRange("Posting Date", gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End");
        end else begin
            pResLedgEntry.SetRange("Planning Source", true);
            pResLedgEntry.SetRange("Resource No.", MatrixRecords[pColumnID]."No.");
            if pRes."Employment Date" = pRes."Last Date Modified" then
                pResLedgEntry.SetRange("Posting Date", pRes."Employment Date")
            else
                pResLedgEntry.SetRange("Posting Date", pRes."Employment Date", pRes."Last Date Modified");
        end;
    end;


    procedure SetFilters()
    begin
        if not wPerDate then begin
            //Type ressource
            if ResourceTypeFilter = 0 then
                rec.SetRange(Type)
            else
                rec.SetRange(Type, ResourceTypeFilter - 1);
            //Code nature
            if ResProdPostGroupFilter = '' then
                rec.SetRange("Gen. Prod. Posting Group")
            else
                rec.SetFilter("Gen. Prod. Posting Group", ResProdPostGroupFilter);
        end else begin
            //Type ressource
            if ResourceTypeFilter = 0 then
                MatrixRecord.SetRange(Type)
            else
                MatrixRecord.SetRange(Type, ResourceTypeFilter - 1);
            //Code nature
            if ResProdPostGroupFilter = '' then
                MatrixRecord.SetRange("Gen. Prod. Posting Group")
            else
                MatrixRecord.SetFilter("Gen. Prod. Posting Group", ResProdPostGroupFilter);
        end;

        //Filter compétence
        if rec.GetFilter("Res. Group Filter") = '' then
            rec.SetRange("In Res. Group")
        else
            rec.SetRange("In Res. Group", true);
    end;


    procedure fInitialise()
    begin
        QtyType := Qtytype::"Net Change";
        PlanningMgt.Setup;
        xShowOption := ShowOption;
        ValidateColumnDimCode;
        ValidateLineDimCode;
        SetFilters;
        KOClose := false;
    end;

    local procedure ValidateLineDimCode()
    var
        BusUnit: Record 220;
    begin
        LineDimOption := wPerDate;
    end;

    local procedure ValidateColumnDimCode()
    var
        BusUnit: Record 220;
    begin
        ColumnDimOption := not wPerDate;
    end;


    procedure fRefreshData()
    var
        lIndex: Integer;
    begin
        lIndex := 0;
        while (lIndex < MATRIX_CurrSetLength) do begin
            lIndex += 1;
            MATRIX_OnAfterGetRecord(lIndex);
        end;
    end;


    procedure MatrixOnValidate(pColumnID: Integer)
    begin
        if ShowOption = Showoption::Capacity then
            Error(tDisableForShowOption);
        if CellText <> '' then
            Evaluate(Default.Quantity, MATRIX_CellData[pColumnID]);
        Paste(pColumnID, Default);
    end;


    procedure MatrixOnAfterValidate(pColumnID: Integer)
    begin
        MATRIX_CellData[pColumnID] := '';
    end;


    procedure MatrixOnDrillDown(pColumnID: Integer)
    var
        lPlanningTmp: Record 8004130 temporary;
        lCapacity: Record 160;
    begin
        //IF Default."Job No."<>'' THEN
        //  lPlanning.SETRANGE("Job No.",Default."Job No.");
        //IF Default."Prod. Posting Group" <> '' THEN
        //  lPlanning.SETRANGE("Prod. Posting Group",Default."Prod. Posting Group");
        case ShowOption of
            Showoption::Capacity:
                begin
                    SetCellFiltersCapacity(pColumnID, lCapacity);
                    if Default.Quantity <> 0 then
                        lCapacity.SetRange(lCapacity.Capacity, Default.Quantity);
                    page.RunModal(page::"Res. Capacity Entries", lCapacity);
                end;
            else begin
                SetPlanningCellFilters_MATRIX(pColumnID, lPlanningTmp, Rec);
                if Default.Quantity <> 0 then
                    lPlanningTmp.SetRange(Quantity, Default.Quantity);
                if Default.Description <> '' then
                    lPlanningTmp.SetRange(Description, Default.Description);
                //#8433
                //FORM.RUN(FORM::"Planning Detail",lPlanningTmp);
                //GL2024    page.RunModal(page::"Planning Detail", lPlanningTmp);
                //#8433//
            end;
        end;
        //#8433
        fRefreshData();
        //#8433//
    end;


    procedure Paste(pColumnID: Integer; pPlanning: Record 8004130)
    var
        lPlanning: Record 8004130;
        lPlanningQuantity: Record 8004130;
        lResCapacityEntry: Record 160;
        lRes: Record 156;
        lDate: Date;
    begin
        if (pColumnID <= 0) or (pColumnID > MATRIX_CurrSetLength) then
            exit;

        lPlanning := pPlanning;
        if not wPerDate then begin
            lRes := Rec;
            lDate := gMatrixPeriods[pColumnID]."Period Start";
        end else begin
            lRes := MatrixRecords[pColumnID];
            lDate := rec."Employment Date";
        end;

        with lRes do begin
            if Type = Type::Person then
                lPlanning.Type := lPlanning.Type::Person
            else
                lPlanning.Type := lPlanning.Type::Machine;
            lPlanning.Date := lDate;
            lPlanning.Validate("No.", "No.");
            if (lPlanning."Prod. Posting Group" = '') and ("Gen. Prod. Posting Group" <> '') then
                lPlanning."Prod. Posting Group" := "Gen. Prod. Posting Group";
            if (lPlanning."Resource Group No." = '') and ("Resource Group No." <> '') then
                lPlanning."Resource Group No." := "Resource Group No.";
            if lPlanning.Quantity = 0 then begin
                lResCapacityEntry.SetCurrentkey("Resource No.", Date);
                lResCapacityEntry.SetRange("Resource No.", "No.");
                lResCapacityEntry.SetRange(Date, lPlanning.Date);
                lResCapacityEntry.CalcSums(Capacity);
                lPlanningQuantity.SetCurrentkey(Type, "No.");
                if Type = Type::Person then
                    lPlanningQuantity.SetRange(Type, lPlanning.Type::Person)
                else
                    lPlanningQuantity.SetRange(Type, lPlanning.Type::Machine);
                lPlanningQuantity.SetRange("No.", "No.");
                lPlanningQuantity.SetRange(Date, lPlanning.Date);
                lPlanningQuantity.CalcSums(Quantity);
                lPlanning.Quantity := lResCapacityEntry.Capacity - lPlanningQuantity.Quantity;
            end;
        end;

        PlanningMgt.CheckInsert(lPlanning, lDate, Default);
    end;


    procedure SetCellFiltersCapacity(pColumnID: Integer; var pCapacity: Record 160)
    begin
        if (pColumnID <= 0) or (pColumnID > MATRIX_CurrSetLength) then
            exit;

        if not wPerDate then begin
            pCapacity.SetCurrentkey("Resource No.", Date);
            pCapacity.SetRange("Resource No.", rec."No.");
            if gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End" then
                pCapacity.SetRange(Date, gMatrixPeriods[pColumnID]."Period Start")
            else
                pCapacity.SetRange(Date, gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End");
        end else begin
            pCapacity.SetCurrentkey("Resource No.", Date);
            pCapacity.SetRange("Resource No.", MatrixRecords[pColumnID]."No.");
            if rec."Employment Date" = rec."Last Date Modified" then
                pCapacity.SetRange(Date, rec."Employment Date")
            else
                pCapacity.SetRange(Date, rec."Employment Date", rec."Last Date Modified");
        end;
    end;

    local procedure FindRec(pPerDate: Boolean; var DimCodeBuf: Record 156; Which: Text[250]): Boolean
    var
        Res: Record 156;
        Period: Record Date;
        PeriodFormMgt: Codeunit PeriodPageManagement;
        Found: Boolean;
    begin
        if not pPerDate then begin
            //  Res.SETCURRENTKEY(Type,"No.","WT Allowed");
            Res.CopyFilters(CurrentRes);
            Res."No." := DimCodeBuf."No.";
            case ResourceTypeFilter of
                0:
                    Res.SetFilter(Type, '%1|%2', Res.Type::Person, Res.Type::Machine);
                1:
                    Res.SetRange(Type, Res.Type::Person);
                2:
                    Res.SetRange(Type, Res.Type::Machine);
                else
                    ;
            end;
            Res.SetRange(Blocked, false);
            /*
              CASE ResourceStatusFilter OF
            //#4747
            //    0 : Res.SETRANGE(Status,Res.Status::Internal,Res.Status::External);
                0 : Res.SETRANGE(Status);
            //#4747//
                1 : Res.SETRANGE(Status,Res.Status::"0");
                2 : Res.SETRANGE(Status,Res.Status::"1");
                3 : Res.SETRANGE(Status,Res.Status::"2");
                ELSE;
              END;
            */
            rec.Copyfilter("Res. Group Filter", Res."Res. Group Filter");
            Res.SetRange("In Res. Group", true);
            Found := Res.Find(Which);
            if Found then
                DimCodeBuf := Res;
        end else begin
            Period."Period Start" := DimCodeBuf."Employment Date";
            Found := PeriodFormMgt.FindDate(Which, Period, PeriodType);
            if Found then
                CopyPeriodToBuf(Period, DimCodeBuf);
        end;
        exit(Found);

    end;

    local procedure NextRec(pPerDate: Boolean; var DimCodeBuf: Record 156; Steps: Integer): Integer
    var
        Res: Record 156;
        Period: Record Date;
        PeriodFormMgt: Codeunit PeriodPageManagement;
        ResultSteps: Integer;
    begin
        if not pPerDate then begin
            //  Res.SETCURRENTKEY(Type,"No.","WT Allowed");
            Res.CopyFilters(CurrentRes);
            Res."No." := DimCodeBuf."No.";
            case ResourceTypeFilter of
                0:
                    Res.SetFilter(Type, '%1|%2', Res.Type::Person, Res.Type::Machine);
                1:
                    Res.SetRange(Type, Res.Type::Person);
                2:
                    Res.SetRange(Type, Res.Type::Machine);
                else
                    ;
            end;
            /*
              CASE ResourceStatusFilter OF
            //#4747
            //    0 : Res.SETRANGE(Status,Res.Status::Internal,Res.Status::External);
                0 : Res.SETRANGE(Status);
            //#4747//
                1 : Res.SETRANGE(Status,Res.Status::"0");
                2 : Res.SETRANGE(Status,Res.Status::"1");
                3 : Res.SETRANGE(Status,Res.Status::"2");
              ELSE;
              END;
            */
            Res.SetRange(Blocked, false);
            rec.Copyfilter("Res. Group Filter", Res."Res. Group Filter");
            Res.SetRange("In Res. Group", true);
            ResultSteps := Res.Next(Steps);
            if ResultSteps <> 0 then
                DimCodeBuf := Res;
        end
        else begin
            Period."Period Start" := DimCodeBuf."Employment Date";
            ResultSteps := PeriodFormMgt.NextDate(Steps, Period, PeriodType);
            if ResultSteps <> 0 then
                CopyPeriodToBuf(Period, DimCodeBuf);
        end;
        exit(ResultSteps);

    end;

    local procedure CopyPeriodToBuf(var ThePeriod: Record Date; var TheDimCodeBuf: Record 156)
    var
        Period2: Record Date;
    begin
        with TheDimCodeBuf do begin
            Init;
            "No." := Format(ThePeriod."Period Start");
            "Employment Date" := ThePeriod."Period Start";
            "Last Date Modified" := ThePeriod."Period End";
            Name := ThePeriod."Period Name";
            "Unit Price" := ThePeriod."Period No.";
        end;
    end;


    procedure Allocate(pColumnID: Integer)
    begin
        //SalesLinePlanning.TESTFIELD("Sales Document No.");
        //IF PeriodType <> PeriodType::Day THEN
        //  ERROR(tPeriodType);
        //SalesLinePlanning.VALIDATE("Job No.",Default."Job No.");
        //SalesLinePlanning.Quantity := Default.Quantity;
        Paste(pColumnID, Default);
    end;


    procedure InitRequest(var pSalesLine: Record 37; pDate: Date; var pDefault: Record 8004130)
    begin
        Default.Validate("Job No.", pSalesLine."Job No.");
        Default."Job Task No." := pSalesLine."Job Task No.";
        //SalesLinePlanning."Prod. Posting Group" := pSalesLine."Gen. Prod. Posting Group";
        //CurrForm.Matrix.MatrixRec."Period Start" := pDate;
        gDateFilter := Format(pDate);
        MatrixRecord."Employment Date" := pDate;
    end;


    procedure InitFilters(var pResource: Record 156)
    begin
        if pResource.GetFilter(Type) <> '' then
            case pResource.GetRangeMin(Type) of
                pResource.Type::Person:
                    ResourceTypeFilter := Resourcetypefilter::Person;
                pResource.Type::Machine:
                    ResourceTypeFilter := Resourcetypefilter::Machine;
                else
                    ResourceTypeFilter := Resourcetypefilter::" ";
            end;
        /*
        IF pResource.GETFILTER(Status) <> '' THEN
          CASE pResource.GETRANGEMIN(Status) OF
            pResource.Status::"0" : ResourceStatusFilter := ResourceStatusFilter::Internal;
            pResource.Status::"1" : ResourceStatusFilter := ResourceStatusFilter::External;
            pResource.Status::"2" : ResourceStatusFilter := ResourceStatusFilter::Generic;
            ELSE ResourceStatusFilter := ResourceStatusFilter::" ";
          END;
        */
        if pResource.GetFilter("Gen. Prod. Posting Group") <> '' then
            ResProdPostGroupFilter := pResource."Gen. Prod. Posting Group";
        //SetFilters;
        if Rec.Get(pResource."No.") then;

    end;

    local procedure ShowOptionOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure HighLightProdPostingGroupOnAft()
    begin
        CurrPage.Update;
    end;

    local procedure gShowHistoryOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure DefaultPlanningTaskNoOnAfterVa()
    begin
        CurrPage.Update(false);
    end;

    local procedure ResGroupFilterOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure ResourceStatusFilterOnAfterVal()
    begin
        CurrPage.Update(false);
    end;

    local procedure ResourceTypeFilterOnAfterValid()
    begin
        CurrPage.Update(false);
    end;

    local procedure ResProdPostGroupFilterOnAfterV()
    begin
        CurrPage.Update(false);
    end;

    local procedure MATRIXCellData1OnAfterValidate()
    begin
        MatrixOnAfterValidate(1);
    end;

    local procedure MATRIXCellData2OnAfterValidate()
    begin
        MatrixOnAfterValidate(2);
    end;

    local procedure MATRIXCellData3OnAfterValidate()
    begin
        MatrixOnAfterValidate(3);
    end;

    local procedure MATRIXCellData4OnAfterValidate()
    begin
        MatrixOnAfterValidate(4);
    end;

    local procedure MATRIXCellData5OnAfterValidate()
    begin
        MatrixOnAfterValidate(5);
    end;

    local procedure MATRIXCellData6OnAfterValidate()
    begin
        MatrixOnAfterValidate(6);
    end;

    local procedure MATRIXCellData7OnAfterValidate()
    begin
        MatrixOnAfterValidate(7);
    end;

    local procedure MATRIXCellData8OnAfterValidate()
    begin
        MatrixOnAfterValidate(8);
    end;

    local procedure MATRIXCellData9OnAfterValidate()
    begin
        MatrixOnAfterValidate(9);
    end;

    local procedure MATRIXCellData10OnAfterValidat()
    begin
        MatrixOnAfterValidate(10);
    end;

    local procedure MATRIXCellData11OnAfterValidat()
    begin
        MatrixOnAfterValidate(11);
    end;

    local procedure MATRIXCellData12OnAfterValidat()
    begin
        MatrixOnAfterValidate(12);
    end;

    local procedure MATRIXCellData13OnAfterValidat()
    begin
        MatrixOnAfterValidate(13);
    end;

    local procedure MATRIXCellData14OnAfterValidat()
    begin
        MatrixOnAfterValidate(14);
    end;

    local procedure MATRIXCellData15OnAfterValidat()
    begin
        MatrixOnAfterValidate(15);
    end;

    local procedure MATRIXCellData16OnAfterValidat()
    begin
        MatrixOnAfterValidate(16);
    end;

    local procedure MATRIXCellData17OnAfterValidat()
    begin
        MatrixOnAfterValidate(17);
    end;

    local procedure MATRIXCellData18OnAfterValidat()
    begin
        MatrixOnAfterValidate(18);
    end;

    local procedure MATRIXCellData19OnAfterValidat()
    begin
        MatrixOnAfterValidate(19);
    end;

    local procedure MATRIXCellData20OnAfterValidat()
    begin
        MatrixOnAfterValidate(20);
    end;

    local procedure MATRIXCellData21OnAfterValidat()
    begin
        MatrixOnAfterValidate(21);
    end;

    local procedure MATRIXCellData22OnAfterValidat()
    begin
        MatrixOnAfterValidate(22);
    end;

    local procedure MATRIXCellData23OnAfterValidat()
    begin
        MatrixOnAfterValidate(23);
    end;

    local procedure MATRIXCellData25OnAfterValidat()
    begin
        MatrixOnAfterValidate(25);
    end;

    local procedure MATRIXCellData26OnAfterValidat()
    begin
        MatrixOnAfterValidate(26);
    end;

    local procedure MATRIXCellData27OnAfterValidat()
    begin
        MatrixOnAfterValidate(27);
    end;

    local procedure MATRIXCellData28OnAfterValidat()
    begin
        MatrixOnAfterValidate(28);
    end;

    local procedure MATRIXCellData29OnAfterValidat()
    begin
        MatrixOnAfterValidate(29);
    end;

    local procedure MATRIXCellData30OnAfterValidat()
    begin
        MatrixOnAfterValidate(30);
    end;

    local procedure MATRIXCellData31OnAfterValidat()
    begin
        MatrixOnAfterValidate(31);
    end;

    local procedure MATRIXCellData32OnAfterValidat()
    begin
        MatrixOnAfterValidate(32);
    end;

    local procedure NoOnFormat()
    var
        lForeColor: Integer;
        lDate: Record Date;
        lText: Text[1024];
    begin
        if wPerDate then
            if PeriodType = Periodtype::Day then begin
                lDate.SetRange("Period Type", lDate."period type"::Date);
                lDate.SetRange("Period Start", rec."Employment Date");
                lDate.Find('-');
                PlanningMgt.DateTitle(lDate, lText, lForeColor);
                if lForeColor <> 0 then;
            end;
    end;

    local procedure NameOnFormat()
    var
        lForeColor: Integer;
        lDate: Record Date;
        lText: Text[1024];
    begin
        if wPerDate then
            if PeriodType = Periodtype::Day then begin
                lDate.SetRange("Period Type", lDate."period type"::Date);
                lDate.SetRange("Period Start", rec."Employment Date");
                lDate.Find('-');
                PlanningMgt.DateTitle(lDate, lText, lForeColor);
                if lForeColor <> 0 then;
            end;
    end;
}

