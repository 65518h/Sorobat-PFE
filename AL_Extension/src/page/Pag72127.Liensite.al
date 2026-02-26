//GL3900 
// Page 72127 "Lien site"
// {//GL2024  ID dans Nav 2009 : "39002127"
//     //  STRSUBSTNO('%1%2',

//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = ListPart;
//     SourceTable = Liens;
//     SourceTableView = sorting(tri)
//                       order(ascending);
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000014)
//             {
//                 IndentationColumn = cd_site_linkIndent;
//                 IndentationControls = cd_site_link;
//                 field(ActualExpansionStatus; ActualExpansionStatus)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Satus';
//                     Editable = false;
//                     // OptionCaption = 'Integer';

//                     trigger OnValidate()
//                     begin
//                         ActualExpansionStatusOnPush;
//                     end;
//                 }
//                 field(cd_site_link; Rec.cd_site_link)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(cd_site; Rec.cd_site)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(cd_box_link; Rec.cd_box_link)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("libellé equipement"; Rec."libellé equipement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {

//         area(processing)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action("Expand All")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Expand All';

//                     trigger OnAction()
//                     begin
//                         ExpandAll;
//                     end;
//                 }
//                 action(Masque)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Masque';

//                     trigger OnAction()
//                     begin
//                         InitTemplate
//                     end;
//                 }
//             }
//             action("Site Card")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Site Card';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     if SIT.Get(Rec.cd_site_link) then
//                         PAGE.Run(90004, SIT);
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         cd_site_linkIndent := 0;
//         if IsExpanded(Rec) then
//             ActualExpansionStatus := 1
//         else
//             if HasChildren(Rec) then
//                 ActualExpansionStatus := 0
//             else
//                 ActualExpansionStatus := 2;
//         cdsitelinkOnFormat;
//     end;

//     trigger OnFindRecord(Which: Text): Boolean
//     var
//         found: Boolean;
//     begin
//         TempRec.Copy(Rec);
//         found := TempRec.Find(Which);
//         Rec := TempRec;
//         exit(found);
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     var
//         RecRef: RecordRef;
//         ChangeLogMgt: Codeunit "Change Log Management";
//     begin
//         TempRec := Rec;
//         RecRef.GetTable(Rec);
//         ChangeLogMgt.LogInsertion(RecRef);
//         exit(TempRec.Insert);
//     end;

//     trigger OnNextRecord(Steps: Integer): Integer
//     var
//         ResultSteps: Integer;
//     begin
//         TempRec.Copy(Rec);
//         ResultSteps := TempRec.Next(Steps);
//         Rec := TempRec;
//         exit(ResultSteps);
//     end;

//     trigger OnOpenPage()
//     begin
//         InitTemplate;
//         if compoTmp.tri <> '' then begin
//             Rec.SetFilter(tri, '%1..%2', compoTmp.tri, (CopyStr(compoTmp.tri, 1, 3) +
//              '999999999999999999999999999999'));
//             ExpandAll;
//         end;
//     end;

//     var
//         ActualExpansionStatus: Integer;
//         TempRec: Record Liens temporary;
//         SIT: Record Site;
//         temp: Record Liens;
//         compoTmp: Record Liens;
//         [InDataSet]
//         cd_site_linkEmphasize: Boolean;
//         [InDataSet]
//         cd_site_linkIndent: Integer;


//     procedure InitTemplate()
//     begin
//         CopyRecToTemp(true);
//     end;


//     procedure CopyRecToTemp(onlyRoot: Boolean)
//     var
//         HierRec: Record Liens;
//     begin
//         TempRec.DeleteAll;
//         TempRec.SetCurrentkey(cd_compo);
//         if onlyRoot then
//             HierRec.SetRange(HierRec.identation, 0);
//         HierRec.SetFilter(HierRec.typ_subtype, '3');
//         if HierRec.Find('-') then
//             repeat
//                 TempRec := HierRec;
//                 TempRec.Insert;
//             until HierRec.Next = 0;
//     end;


//     procedure ToogleExpand(compo: Record Liens)
//     begin
//         if ActualExpansionStatus = 0 then begin // Has children, but not expanded

//             temp.Reset;
//             temp.SetFilter(temp.cd_site, compo.cd_site_link);
//             temp.SetRange(temp.identation, compo.identation + 1);
//             compo := temp;

//             if temp.Find('-') then
//                 repeat
//                     if temp.identation > Rec.identation then begin
//                         TempRec := temp;
//                         TempRec.SetCurrentkey(TempRec.tri);

//                         if TempRec.Insert then;
//                     end;
//                 until (temp.Next = 0) or (temp.identation = Rec.identation);
//         end else
//             if ActualExpansionStatus = 1 then begin // Has children and is already expanded
//                 TempRec := Rec;
//                 while (TempRec.Next <> 0) and (TempRec.identation > Rec.identation) do
//                     TempRec.Delete;
//             end;
//         CurrPage.Update;
//     end;


//     procedure HasChildren(ActualRec: Record Liens): Boolean
//     var
//         compo: Record Liens;
//     begin
//         compo := ActualRec;
//         compo.Reset;
//         compo.SetFilter(compo.cd_site, ActualRec.cd_site_link);
//         if not compo.Find('-') then
//             exit(false)
//         else
//             exit(compo.identation > ActualRec.identation);
//     end;


//     procedure IsExpanded(ActualRec: Record Liens): Boolean
//     begin
//         TempRec := ActualRec;

//         TempRec.Reset;
//         TempRec.SetFilter(TempRec.cd_site, ActualRec.cd_site_link);

//         //IF TempRec.NEXT = 0 THEN
//         if not TempRec.Find('-') then
//             exit(false)
//         else
//             exit(TempRec.identation > ActualRec.identation);
//     end;


//     procedure ExpandAll()
//     begin
//         CopyRecToTemp(false);
//     end;


//     procedure InitArb(var Rec: Record Liens)
//     begin
//         Clear(compoTmp);
//         compoTmp := Rec;
//     end;

//     local procedure ActualExpansionStatusOnPush()
//     begin
//         ToogleExpand(Rec);
//     end;

//     local procedure cdsitelinkOnFormat()
//     begin
//         if Rec.identation = 0 then
//             cd_site_linkEmphasize := true;

//         if Rec.identation > 0 then
//             cd_site_linkIndent := Rec.identation * 300;
//     end;
// }

