PageExtension 50044 "Resource Card_PagEXT" extends "Resource Card"
{
    layout
    {
        modify(Blocked)
        {
            Editable = BlockedEDITABLE;
        }
        addafter("No.")
        {
            field("Code Etude"; Rec."Code Etude")
            {
                ApplicationArea = all;
            }
            field("WT Allowed"; Rec."WT Allowed")
            {
                ApplicationArea = all;
            }
            field("Tree Code"; Rec."Tree Code")
            {
                ApplicationArea = all;
            }
            field("MO Conducteur Engin"; Rec."MO Conducteur Engin")
            {
                ApplicationArea = all;
            }
            field(Equipment; Rec.Equipment) { ApplicationArea = all; }


        }

        addafter("Last Date Modified")
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = all;
            }
            field("Default Rate Quantity"; Rec."Default Rate Quantity")
            {
                ApplicationArea = all;
            }
            field("Default Number of Resources"; Rec."Default Number of Resources")
            {
                ApplicationArea = all;
            }
            field(Qualification; Rec.Qualification)
            {
                ApplicationArea = all;
            }
        }

        addafter("Base Unit of Measure")
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = all;
            }
        }
        modify("Base Unit of Measure")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                lResUnitOfMeasure: Record 205;
                lUnitOfMeasure: Record 204;
            begin
                //+REF+UNIT
                WITH lResUnitOfMeasure DO BEGIN
                    SETRANGE("Resource No.", rec."No.");
                    IF ISEMPTY THEN BEGIN
                        IF page.RUNMODAL(0, lUnitOfMeasure) = ACTION::LookupOK THEN BEGIN
                            rec."Base Unit of Measure" := lUnitOfMeasure.Code;
                            "Resource No." := rec."No.";
                            Code := rec."Base Unit of Measure";
                            "Qty. per Unit of Measure" := 1;
                            INSERT;
                        END;
                    END ELSE
                        IF page.RUNMODAL(0, lResUnitOfMeasure) = ACTION::LookupOK THEN BEGIN
                            TESTFIELD("Qty. per Unit of Measure", 1);
                            rec."Base Unit of Measure" := Code;
                        END;
                END;
                //+REF+UNIT//

            end;
        }



        addafter("IC Partner Purch. G/L Acc. No.")
        {
            field("Bal. Job No."; Rec."Bal. Job No.")
            {
                ApplicationArea = all;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = all;
            }
            field("Work Type Code"; Rec."Work Type Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Unit Price")
        {
            field("Resource Disc. Group"; Rec."Resource Disc. Group")
            {
                ApplicationArea = all;
            }
            field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
            {
                ApplicationArea = all;
            }
        }

        addafter("Employment Date")
        {
            field("Travel Code"; Rec."Travel Code")
            {
                ApplicationArea = all;
            }
            field("Responsible No."; Rec."Responsible No.")
            {
                ApplicationArea = all;
            }
            field("Tree Code2"; Rec."Tree Code")
            {
                ApplicationArea = all;
            }
            field("Weekly Schedule Code"; Rec."Weekly Schedule Code")
            {
                ApplicationArea = all;
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
            }


        }
    }

    actions
    {
        addafter("&Picture")
        {
            /*//DYS   action("Job Ledger Entries")
               {
                   ShortCutKey = 'Ctrl+F5';
                   ApplicationArea = all;
                   Caption = 'Job Ledger Entries';
                   //DYS page addon non migrer
                   // RunObject = Page 8004162;
                   // RunPageView = SORTING(Type, "No.", "Posting Date", "Job No.", "Work Type Code") WHERE("Bal. Created Entry" = CONST(false));
                   // RunPageLink = Type = CONST(Resource),
                   //                   "No." = FIELD("No.");
               }*/
        }
        addafter("Units of Measure_Promoted")
        {
            actionref("Folder1"; "Folder")
            {

            }
        }

        addafter("E&xtended Texts")
        {
            action("Folder")
            {
                Caption = 'Folder';
                ApplicationArea = all;

                trigger OnAction()
                VAR
                    lFolderManagement: Codeunit "Folder management";
                BEGIN

                    //+REF+FOLDER
                    lFolderManagement.Resource(Rec);
                    //+REF+FOLDER//

                end;
            }
            /*  //DYS   action("Characteristics")
               {
                   Caption = 'Characteristics';
                   ApplicationArea = all;
                   //DYS page addon non migrer
                   // RunObject = Page 8001403;
                   // RunPageLink = "Table Name" = CONST(Resource),
                   //                   "No." = FIELD(No.) ;
               }*/
        }

        addafter("Online Map")
        {
            /*DYS  action("Interim Missions")
             {
                 Caption = 'Interim Missions';
                 ApplicationArea = all;
                 //DYS page addon non migrer
                 // RunObject = Page 8004020;
                 // RunPageLink = "Resource No." = FIELD("No.");
             }*/
            /*DYS     action("Resource Groups")
                {
                    Caption = 'Resource Groups';
                    ApplicationArea = all;
                    //DYS page addon non migrer
                    // RunObject = Page 8004033;
                    // RunPageView = SORTING("Resource No.", "Resource Group No.");
                    // RunPageLink = "Resource No." = FIELD("No.");
                }*/
        }

        addafter(Prices)
        {
            // action("Line Discount")
            // {
            //     Caption = 'Resource Groups';
            //     ApplicationArea = all;

            //     RunObject = Page 7004;
            //     RunPageView = SORTING(Type, Code);
            //     RunPageLink = Type = CONST(Resource),
            //                       Code = FIELD("No.");
            // }
        }

        addafter("Resource A&vailability")
        {
            /*DYS   action("Planning Skills")
              {
                  Caption = 'Planning Skills';
                  ApplicationArea = all;
                  //DYS page addon non migrer
                  // RunObject = Page 8005017;
                  // RunPageView = SORTING("No.", "Skill Code");
                  // RunPageLink = "No." = FIELD("No.");
              }*/
        }
        modify("Ledger E&ntries")
        {
            Visible = false;
        }

        addafter(CreateTimeSheets)
        {
            /*DYS   action(Copy)
              {
                  Caption = 'Copy';
                  ApplicationArea = all;

                  trigger OnAction()
                  VAR
                  //DYS REPORT addon non migrer
                  // lCopyResource: Report "Copy Resource";
                  BEGIN

                      //+REF+COPY
                      rec.TESTFIELD("No.");
                      rec.SETRANGE("No.", rec."No.");
                      //DYS
                      // CLEAR(lCopyResource);
                      // lCopyResource.InitRequest(rec.Type);
                      // lCopyResource.SETTABLEVIEW(Rec);
                      // lCopyResource.RUNMODAL;
                      //+REF+COPY//

                  end;
              }*/
        }
        addafter(History)
        {
            action("Wor&Kflow")
            {
                Caption = 'Wor&Kflow';
                ApplicationArea = all;

                trigger OnAction()
                VAR
                    lRecordRef: RecordRef;
                    lWorkflowConnector: Codeunit "Workflow Connector";
                BEGIN

                    lRecordRef.GETTABLE(Rec);
                    lWorkflowConnector.OnPush(PAGE::"Resource Card", lRecordRef);

                end;
            }
        }
        addafter(Category_Synchronize)
        {
            actionref("Wor&Kflow1"; "Wor&Kflow")
            {

            }
        }
    }






    trigger OnOpenPage()
    var
        lRTCEditable: Boolean;
        lWorkflowSetup: Record "Workflow Setup";

    begin


        //+WKF+CUSTOM
        lRTCEditable := TRUE;
        IF gAddOnLicencePermission.HasPermissionWKF() THEN
            IF lWorkflowSetup.GET AND lWorkflowSetup."Block New Item" THEN
                lRTCEditable := FALSE;
        BlockedEDITABLE := lRTCEditable;
        //+WKF+CUSTOM//

        //RESSOURCE
        //rec.SETRANGE(Type, rec.Type::Person);
        //RESSOURCE//
    end;


    trigger OnNewRecord(BelowxRec: Boolean)
    VAR
        lRecordRef: RecordRef;
        lTemplateMgt: Codeunit "Config. Template Management";
        CduFunction: Codeunit SoroubatFucntion;
    begin

        //POINTAGE
        rec.Type := rec.GETRANGEMAX(Type);
        //POINTAGE//
        //+REF+TEMPLATE
        lRecordRef.GETTABLE(Rec);
        IF NOT CduFunction.GetTemplate(lRecordRef) THEN
            Currpage.CLOSE;
        lRecordRef.SETTABLE(Rec);
        //+REF+TEMPLATE//
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    VAR
        lProcessusWKFIntegr: Codeunit "Processus workflow Integr.";
    begin


        //+WKF+CUSTOM
        IF gAddOnLicencePermission.HasPermissionWKF() THEN
            lProcessusWKFIntegr.OnInsertResource(Rec);
        //+WKF+CUSTOM//
    end;




    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
        MapPointVISIBLE: Boolean;
        BlockedEDITABLE: Boolean;
}



