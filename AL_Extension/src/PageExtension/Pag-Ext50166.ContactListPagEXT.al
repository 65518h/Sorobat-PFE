PageExtension 50166 "Contact List_PagEXT" extends "Contact List"
{

    layout
    {


        addbefore(Control1)
        {

            field("Nom de la société"; gSearchCompanyName)
            {
                Caption = 'Nom de la société';
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    //+REF+SEARCH_NAME
                    fSetFilters;
                    //+REF+SEARCH_NAME//
                end;
            }
            field("Business Relation Filter"; rec."Business Relation Filter")
            {
                TableRelation = "Business Relation";
                ApplicationArea = all;
                trigger OnValidate()
                begin

                    IF rec.GETFILTER("Business Relation Filter") = '' THEN
                        rec.SETRANGE("No. of Business Relations")
                    ELSE
                        rec.SETFILTER("No. of Business Relations", '<>%1', 0);
                    CurrPage.UPDATE(FALSE);
                end;
            }
            field("Nom de recherche"; gSearchName)
            {
                Caption = 'Search Description';
                ApplicationArea = all;
                trigger OnValidate()
                begin

                    //+REF+SEARCH_NAME
                    fSetFilters;
                    //+REF+SEARCH_NAME//
                end;
            }
        }
        modify(Control1)
        {
            Editable = false;
        }


        addafter("No.")
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter(Name)
        {
            field(Favorite; Rec.Favorite)
            {
                ApplicationArea = all;
            }
            field("No. of Business Relations"; Rec."No. of Business Relations")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

        addafter("Company Name")
        {
            field("Job Title2"; Rec."Job Title")
            {
                ApplicationArea = all;
            }
            field(Address; Rec.Address)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

        addafter("Post Code")
        {
            field(City; Rec.City)
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

        addafter("Country/Region Code")
        {
            field("E-Mail2"; Rec."E-Mail")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Home Page"; Rec."Home Page")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }



    }
    actions
    {
        addafter("Segmen&ts")
        {
            /*GL2024 action("Sales Documents List")
             {
                 ApplicationArea = all;
                 Caption = 'Sales Documents List';
                 //DYS page addon non migrer
                 // RunObject = Page 8004056;
                 // RunPageLink = "Sell-to Contact No." = FIELD("No.");
                 // RunPageView = SORTING("Order Type", "Document Type", "No.", "Invoicing Method", Finished)
                 //                   WHERE("Order Type" = CONST(" "));
             }*/
            /*GL2024  separator(separator1)
              {

              }*/
            /*GL2024   action("Sales Contributors")
               {
                   ApplicationArea = all;
                   Caption = 'Sales Contributors';
                   //DYS page addon non migrer
                   // RunObject = Page 8003939;
                   // RunPageLink = "Contact No." = FIELD("No.");
               }*/
        }

        addbefore("Interaction Log E&ntries")
        {
            // separator(separator2)
            // {

            // }
            action(Folder)
            {
                Caption = 'Folder';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lFolderManagement: Codeunit "Folder management";
                begin

                    //+REF+FOLDER
                    lFolderManagement.Contact(Rec);
                    //+REF+FOLDER//
                end;
            }
            action("E&tats")
            {
                ApplicationArea = all;
                Caption = 'Etats';

                trigger OnAction()
                var
                    lReportList: Record ReportList;
                    lId: Integer;
                    lRecRef: RecordRef;
                begin

                    WITH lReportList DO BEGIN
                        EVALUATE(lId, COPYSTR(CurrPage.OBJECTID(FALSE), 6));
                        lRecRef.GETTABLE(Rec);
                        SetRecordRef(lRecRef, FALSE);
                        ShowList(lId);
                    END;
                end;
            }
        }
        addafter(Statistics_Promoted)
        {

            actionref(Folder1; Folder) { }

            actionref("E&tats11"; "E&tats") { }
        }
        addafter(MakePhoneCall_Promoted)
        {
            group(Favoris1)
            {
                Caption = 'Favoris';
                actionref("Set Filter1"; "Set Filter") { }

                actionref("Add to Favorites1"; "Add to Favorites") { }

                actionref("Add selection to favorites1"; "Add selection to favorites") { }

                actionref("Filter Favorites1"; "Filter Favorites") { }

                actionref("Delete from Favorites1"; "Delete from Favorites") { }

            }
        }
        addafter(Bank)
        {
            group(Favoris)
            {
                Caption = 'Favoris';
                action("Set Filter")
                {
                    Caption = 'Set Filter';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        lRecordRef: RecordRef;
                        lFilterManagement: Codeunit "Filter Management";
                    begin

                        lRecordRef.GETTABLE(Rec);
                        IF lFilterManagement.GetView(lRecordRef) THEN
                            rec.SETVIEW(lRecordRef.GETVIEW);
                    end;
                }
                action("Add to Favorites")
                {
                    Caption = 'Add to Favorites';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        lRecordRef: RecordRef;
                        lRec: Record Contact;
                        lFavorite: Codeunit "Filter Favorite Management";
                    begin

                        lRec.COPY(Rec);
                        CurrPage.SETSELECTIONFILTER(lRec);
                        lRecordRef.GETTABLE(lRec);
                        lFavorite.AddSelection(lRecordRef);
                    end;
                }
                action("Add selection to favorites")
                {
                    Caption = 'Add selection to favorites';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        lRecordRef: RecordRef;
                        lFavorite: Codeunit "Filter Favorite Management";
                    begin

                        lRecordRef.GETTABLE(Rec);
                        lFavorite.Toggle(lRecordRef);
                    end;
                }
                action("Filter Favorites")
                {
                    Caption = 'Filter Favorites';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        rec."User Favorite Filter" := USERID;
                        rec.SETRANGE(Favorite, TRUE);
                    end;
                }
                action("Delete from Favorites")
                {
                    Caption = 'Delete from Favorites';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        lRec: Record Contact;
                        lRecordRef: RecordRef;
                        lFavorite: Codeunit "Filter Favorite Management";
                    begin

                        lRec.COPY(Rec);
                        CurrPage.SETSELECTIONFILTER(lRec);
                        lRecordRef.GETTABLE(lRec);
                        lFavorite.RemoveSelection(lRecordRef);
                    end;
                }

            }
        }
    }

    PROCEDURE fSetFilters();
    BEGIN
        //+REF+SEARCH_NAME
        IF gSearchName <> '' THEN
            rec.SETCURRENTKEY("Search Name")
        ELSE
            IF gSearchCompanyName <> '' THEN
                rec.SETCURRENTKEY("Company Name", "Company No.", Type, "Search Name");

        IF gSearchName = '' THEN
            rec.SETRANGE("Search Name")
        ELSE
            rec.SETFILTER("Search Name", gSearchName + '*');

        IF gSearchCompanyName = '' THEN
            rec.SETRANGE("Company Name")
        ELSE
            rec.SETFILTER("Company Name", '@' + gSearchCompanyName + '*');

        CurrPage.UPDATE(FALSE);
        //+REF+SEARCH_NAME//
    END;

    trigger OnOpenPage()
    begin
        //FAVORITE
        rec.SETRANGE("User Favorite Filter", USERID)
        //FAVORITE//
    end;


    var
        gSearchName: Text[250];
        gSearchCompanyName: Text[30];
}