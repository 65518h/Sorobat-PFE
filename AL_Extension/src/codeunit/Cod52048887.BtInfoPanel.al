//GL3900
// Codeunit 52048887 BtInfoPanel
// {
//     //GL2024  ID dans Nav 2009 : "39002014"
//     trigger OnRun()
//     begin
//     end;

//     var
//         Item: Record Item;
//         Bt: Record BT;
//         ItemAvailByDate: Page "Item Availability by Periods";
//         ItemAvailByLoc: Page "Item Availability by Location";
//         Text000: label 'You cannot delete the order line because it is associated with purchase order %1 line %2.';
//         Text001: label 'You cannot rename a %1.';
//         Text002: label 'You cannot change %1 because the order line is associated with purchase order %2 line %3.';
//         Text003: label 'must not be less than %1';
//         Text005: label 'You cannot invoice more than %1 units.';
//         Text006: label 'You cannot invoice more than %1 base units.';
//         Text007: label 'You cannot ship more than %1 units.';
//         Text008: label 'You cannot ship more than %1 base units.';
//         Text009: label ' must be 0 when %1 is %2.';
//         Text011: label 'Automatic reservation is not possible.\Reserve items manually?';
//         Text012: label 'Change %1 from %2 to %3?';
//         Text014: label '%1 %2 is before Work Date %3';
//         Text016: label '%1 is required for %2 = %3.';
//         Text017: label '\The entered information will be disregarded by warehouse operations.';
//         Text018: label 'must not be specified when %1 = %2';
//         Text020: label 'You cannot return more than %1 units.';
//         Text021: label 'You cannot return more than %1 base units.';
//         Text023: label '%1 %2 cannot be found in the %3 or %4 table.';
//         Text024: label '%1 and %2 cannot both be empty when %3 is used.';
//         Text025: label 'No %1 has been posted for %2 %3 and %4 %5.';
//         Text026: label 'You cannot change %1 if the item charge has already been posted.';
//         Text028: label 'You cannot change the %1 when the %2 has been filled in.';
//         Text029: label 'must be positive';
//         Text030: label 'must be negative';
//         Text031: label 'You must either specify %1 or %2.';
//         Text032: label 'You must select a %1 that applies to a range of entries when the related service contract is %2.';
//         Text033: label 'You cannot modify the %1 field if the %2 and/or %3 fields are empty.';
//         Text034: label 'The value of %1 field must be a whole number for the item included in the service item group if the %2 field in the Service Item Groups window contains a check mark.';
//         Text035: label 'Warehouse ';
//         Text036: label 'Inventory ';
//         Ressourc: Record Resource;
//         ResAvail: Page "Resource Availability";
//         date: Date;


//     procedure lookupCommentItem(ConsomLine: Record "ARTICLE/BT")
//     var
//         CommentLine: Record "Comment Line";
//         art: Record Item;
//     begin

//         if GetItem(ConsomLine) then begin
//             CommentLine.Reset;
//             CommentLine.SetRange("Table Name", CommentLine."table name"::Item);
//             CommentLine.SetRange("No.", Item."No.");
//             Page.RunModal(Page::"Comment Sheet", CommentLine);
//         end;
//     end;


//     procedure ExistCommentItem(ConsomLine: Record "ARTICLE/BT"): Boolean
//     var
//         art: Record Item;
//     begin
//         if GetItem(ConsomLine) then
//             Item.CalcFields(Item.Comment);
//         exit(Item.Comment);
//     end;


//     procedure CalcAvailability(var ConsomLine: Record "ARTICLE/BT"): Decimal
//     var
//         AvailableToPromise: Codeunit "Available to Promise";
//         GrossRequirement: Decimal;
//         ScheduledReceipt: Decimal;
//         PeriodType: Option Day,Week,Month,Quarter,Year;
//         AvailabilityDate: Date;
//         LookaheadDateformula: DateFormula;
//     begin
//         if GetItem(ConsomLine) then begin

//             if GetBt(ConsomLine) then
//                 AvailabilityDate := Bt.dt_debut
//             else
//                 AvailabilityDate := WorkDate;

//             Item.Reset;
//             Item.SetRange("Date Filter", 0D, AvailabilityDate);
//             Item.SetRange("Location Filter", ConsomLine.magasin);
//             Item.SetRange("Drop Shipment Filter", false);

//             exit(
//                  /* GL2024   AvailableToPromise.QtyAvailabletoPromise(
//                        Item,
//                        GrossRequirement,
//                        ScheduledReceipt,
//                        AvailabilityDate,
//                        PeriodType,
//                        LookaheadDateformula));*/

//                  AvailableToPromise.CalcQtyAvailableToPromise(
//                 Item,
//                 GrossRequirement,
//                 ScheduledReceipt,
//                 AvailabilityDate,
//                 PeriodType,
//                 LookaheadDateformula));

//         end;
//     end;

//     local procedure GetItem(var ConsomLine: Record "ARTICLE/BT"): Boolean
//     begin
//         with Item do begin
//             if (ConsomLine.article = '') then
//                 exit(false);

//             if ConsomLine.article <> "No." then
//                 Get(ConsomLine.article);
//             exit(true);
//         end;
//     end;


//     procedure GetBt(Consom: Record "ARTICLE/BT"): Boolean
//     begin
//         Bt.Reset;
//         Bt.SetFilter(Bt.cd_OT, Consom."code ot");
//         Bt.SetRange(Bt."code BT", Consom."code bt");
//         if Bt.Find('-') then
//             exit(true);
//         exit(false);
//     end;


//     procedure CalcNoOfSubstitutions(var Consom: Record "ARTICLE/BT"): Integer
//     begin
//         if GetItem(Consom) then begin
//             Item.CalcFields(Item."No. of Substitutes");
//             exit(Item."No. of Substitutes");
//         end;
//     end;


//     procedure ItemAvailability(AvailabilityType: Option Date,Location; con: Record "ARTICLE/BT")
//     begin
//         Item.Reset;
//         Item.Get(con.article);
//         Item.SetRange("No.", con.article);
//         if ((GetBt(con)) and (Bt.dt_debut <> 0D)) then
//             date := Bt.dt_debut
//         else
//             date := WorkDate;
//         Item.SetRange("Date Filter", 0D, date);
//         case AvailabilityType of
//             Availabilitytype::Date:
//                 begin
//                     Item.SetRange("Location Filter", con.magasin);
//                     Clear(ItemAvailByDate);
//                     ItemAvailByDate.LookupMode(true);
//                     ItemAvailByDate.SetRecord(Item);
//                     ItemAvailByDate.SetTableview(Item);
//                     if ItemAvailByDate.RunModal = Action::LookupOK then
//                     ;
//                 end;
//             Availabilitytype::Location:
//                 begin
//                     Clear(ItemAvailByLoc);
//                     ItemAvailByLoc.LookupMode(true);
//                     ItemAvailByLoc.SetRecord(Item);
//                     ItemAvailByLoc.SetTableview(Item);
//                     if ItemAvailByLoc.RunModal = Action::LookupOK then
//                     ;
//                     /* IF con.magasin <> ItemAvailByLoc.GetLastLocation THEN
//                        IF CONFIRM(
//                             Text012,TRUE,FIELDCAPTION("Location Code"),"Location Code",
//                             ItemAvailByLoc.GetLastLocation)
//                        THEN BEGIN
//                          IF CurrFieldNo = 0 THEN
//                            xRec := Rec;
//                          VALIDATE("Location Code",ItemAvailByLoc.GetLastLocation);
//                        END;*/
//                 end;
//         end;

//     end;


//     procedure ItemSubstGet(var CONS: Record "ARTICLE/BT"): Code[10]
//     var
//         ITEMSUB: Record "Item Substitution";
//         TEMPITEMSUB: Record "Item Substitution";
//         NonStockItem: Record "Nonstock Item";
//         NonstockItemMgt: Codeunit "Catalog Item Management";
//     begin
//         Item.Get(CONS.article);
//         Item.SetFilter("Location Filter", CONS.magasin);
//         if ((GetBt(CONS)) and (Bt.dt_debut <> 0D)) then
//             date := Bt.dt_debut
//         else
//             date := WorkDate;
//         Item.SetRange("Date Filter", 0D, date);
//         Item.CalcFields(Inventory);
//         Item.CalcFields("Qty. on Sales Order");
//         Item.CalcFields("Qty. on Service Order");

//         ITEMSUB.Reset;
//         ITEMSUB.SetRange(Type, ITEMSUB.Type::Item);
//         ITEMSUB.SetRange("No.", CONS.article);
//         ITEMSUB.SetRange("Location Filter", CONS.magasin);
//         if ITEMSUB.Find('-') then begin
//             TEMPITEMSUB.Reset;
//             TEMPITEMSUB.SetRange("No.", CONS.article);
//             TEMPITEMSUB.SetRange("Location Filter", CONS.magasin);
//             if Page.RunModal(Page::"Item Substitution Entries", TEMPITEMSUB) =
//               Action::LookupOK
//             then begin
//                 if TEMPITEMSUB."Substitute Type" =
//                   TEMPITEMSUB."substitute type"::"Nonstock Item"
//                 then begin
//                     NonStockItem.Get(TEMPITEMSUB."Substitute No.");
//                     if NonStockItem."Item No." = '' then begin
//                         NonstockItemMgt.CreateItemFromNonstock(NonStockItem);
//                         NonStockItem.Get(TEMPITEMSUB."Substitute No.");
//                     end;
//                     TEMPITEMSUB."Substitute No." := NonStockItem."Item No."
//                 end;
//             end;

//         end;
//     end;


//     procedure lookupCommentRes(ResLine: Record "Intervenant/bt")
//     var
//         CommentLine: Record "Comment Line";
//         ress: Record Resource;
//     begin

//         if GetRes(ResLine) then begin
//             CommentLine.Reset;
//             CommentLine.SetRange("Table Name", CommentLine."table name"::Resource);
//             CommentLine.SetRange("No.", Ressourc."No.");
//             Page.RunModal(Page::"Comment Sheet", CommentLine);
//         end;
//     end;


//     procedure ExistCommentRes(ResLine: Record "Intervenant/bt"): Boolean
//     var
//         Ress: Record Resource;
//     begin
//         if GetRes(ResLine) then
//             Ressourc.CalcFields(Ressourc.Comment);
//         exit(Ressourc.Comment);
//     end;

//     local procedure GetRes(ResLine: Record "Intervenant/bt"): Boolean
//     begin
//         with Ressourc do begin
//             if (ResLine.cd_resource = '') then
//                 exit(false);

//             if ResLine.cd_resource <> "No." then
//                 if Get(ResLine.cd_resource) then;
//             exit(true);
//         end;
//     end;


//     procedure ResAvailability(RessLine: Record "Intervenant/bt")
//     var
//         Ress: Record Resource;
//     begin
//         if ((GetBtRes(RessLine)) and (Bt.dt_debut <> 0D)) then
//             date := Bt.dt_debut
//         else
//             date := WorkDate;
//         if GetRes(RessLine) then begin
//             Ressourc.SetRange("Date Filter", 0D, date);
//             ResAvail.SetRecord(Ressourc);
//             ResAvail.Run;
//         end;
//     end;


//     procedure GetBtRes(ResLine: Record "Intervenant/bt"): Boolean
//     begin
//         Bt.Reset;
//         Bt.SetFilter(Bt.cd_OT, ResLine.cd_ot);
//         Bt.SetRange(Bt."code BT", ResLine.cd_bt);
//         if Bt.Find('-') then
//             exit(true);
//         exit(false);
//     end;


//     procedure ShowSkillRes(ResLine: Record "Intervenant/bt")
//     var
//         skill: Record "Resource Skill";
//     begin
//         if GetRes(ResLine) then begin
//             skill.SetFilter(skill.Type, 'Ressource');
//             skill.SetFilter(skill."No.", ResLine.cd_resource);
//             PAGE.Run(Page::"Resource Skills", skill);
//         end;
//     end;


//     procedure ExistCommentItemPrev(ConsomLine: Record "ARTICLE/BTP"): Boolean
//     var
//         art: Record Item;
//     begin
//         if GetItemPrev(ConsomLine) then
//             Item.CalcFields(Item.Comment);
//         exit(Item.Comment);
//     end;

//     local procedure GetItemPrev(var ConsomLine: Record "ARTICLE/BTP"): Boolean
//     begin
//         with Item do begin
//             if (ConsomLine.article = '') then
//                 exit(false);

//             if ConsomLine.article <> "No." then
//                 Get(ConsomLine.article);
//             exit(true);
//         end;
//     end;


//     procedure lookupCommentItemPrev(ConsomLine: Record "ARTICLE/BTP")
//     var
//         CommentLine: Record "Comment Line";
//         art: Record Item;
//     begin

//         if GetItemPrev(ConsomLine) then begin
//             CommentLine.Reset;
//             CommentLine.SetRange("Table Name", CommentLine."table name"::Item);
//             CommentLine.SetRange("No.", Item."No.");
//             Page.RunModal(Page::"Comment Sheet", CommentLine);
//         end;
//     end;


//     procedure CalcAvailabilityprev(var ConsomLine: Record "ARTICLE/BTP"): Decimal
//     var
//         AvailableToPromise: Codeunit "Available to Promise";
//         GrossRequirement: Decimal;
//         ScheduledReceipt: Decimal;
//         PeriodType: Option Day,Week,Month,Quarter,Year;
//         AvailabilityDate: Date;
//         LookaheadDateformula: DateFormula;
//     begin
//         if GetItemPrev(ConsomLine) then begin

//             AvailabilityDate := WorkDate;

//             Item.Reset;
//             Item.SetRange("Date Filter", 0D, AvailabilityDate);
//             Item.SetRange("Location Filter", ConsomLine.magasin);
//             Item.SetRange("Drop Shipment Filter", false);

//             /*GL2024  exit(
//                 AvailableToPromise.QtyAvailabletoPromise(
//                   Item,
//                   GrossRequirement,
//                   ScheduledReceipt,
//                   AvailabilityDate,
//                   PeriodType,
//                   LookaheadDateformula));*/

//             exit(
//       AvailableToPromise.CalcQtyAvailableToPromise(
//         Item,
//         GrossRequirement,
//         ScheduledReceipt,
//         AvailabilityDate,
//         PeriodType,
//         LookaheadDateformula));
//         end;
//     end;


//     procedure ItemAvailabilityPrev(AvailabilityType: Option Date,Location; con: Record "ARTICLE/BTP")
//     begin
//         Item.Reset;
//         Item.Get(con.article);
//         Item.SetRange("No.", con.article);
//         date := WorkDate;
//         Item.SetRange("Date Filter", 0D, date);
//         case AvailabilityType of
//             Availabilitytype::Date:
//                 begin
//                     Item.SetRange("Location Filter", con.magasin);
//                     Clear(ItemAvailByDate);
//                     ItemAvailByDate.LookupMode(true);
//                     ItemAvailByDate.SetRecord(Item);
//                     ItemAvailByDate.SetTableview(Item);
//                     if ItemAvailByDate.RunModal = Action::LookupOK then
//                     ;
//                 end;
//             Availabilitytype::Location:
//                 begin
//                     Clear(ItemAvailByLoc);
//                     ItemAvailByLoc.LookupMode(true);
//                     ItemAvailByLoc.SetRecord(Item);
//                     ItemAvailByLoc.SetTableview(Item);
//                     if ItemAvailByLoc.RunModal = Action::LookupOK then
//                     ;
//                     /* IF con.magasin <> ItemAvailByLoc.GetLastLocation THEN
//                        IF CONFIRM(
//                             Text012,TRUE,FIELDCAPTION("Location Code"),"Location Code",
//                             ItemAvailByLoc.GetLastLocation)
//                        THEN BEGIN
//                          IF CurrFieldNo = 0 THEN
//                            xRec := Rec;
//                          VALIDATE("Location Code",ItemAvailByLoc.GetLastLocation);
//                        END;*/
//                 end;
//         end;

//     end;


//     procedure CalcNoOfSubstitutionsPrev(var Consom: Record "ARTICLE/BTP"): Integer
//     begin
//         if GetItemPrev(Consom) then begin
//             Item.CalcFields(Item."No. of Substitutes");
//             exit(Item."No. of Substitutes");
//         end;
//     end;


//     procedure ItemSubstGetprev(var CONS: Record "ARTICLE/BTP"): Code[10]
//     var
//         ITEMSUB: Record "Item Substitution";
//         TEMPITEMSUB: Record "Item Substitution";
//         NonStockItem: Record "Nonstock Item";
//         NonstockItemMgt: Codeunit "Catalog Item Management";
//     begin
//         Item.Get(CONS.article);
//         Item.SetFilter("Location Filter", CONS.magasin);
//         date := WorkDate;
//         Item.SetRange("Date Filter", 0D, date);
//         Item.CalcFields(Inventory);
//         Item.CalcFields("Qty. on Sales Order");
//         Item.CalcFields("Qty. on Service Order");

//         ITEMSUB.Reset;
//         ITEMSUB.SetRange(Type, ITEMSUB.Type::Item);
//         ITEMSUB.SetRange("No.", CONS.article);
//         ITEMSUB.SetRange("Location Filter", CONS.magasin);
//         if ITEMSUB.Find('-') then begin
//             TEMPITEMSUB.Reset;
//             TEMPITEMSUB.SetRange("No.", CONS.article);
//             TEMPITEMSUB.SetRange("Location Filter", CONS.magasin);
//             if Page.RunModal(Page::"Item Substitution Entries", TEMPITEMSUB) =
//               Action::LookupOK
//             then begin
//                 if TEMPITEMSUB."Substitute Type" =
//                   TEMPITEMSUB."substitute type"::"Nonstock Item"
//                 then begin
//                     NonStockItem.Get(TEMPITEMSUB."Substitute No.");
//                     if NonStockItem."Item No." = '' then begin
//                         NonstockItemMgt.CreateItemFromNonstock(NonStockItem);
//                         NonStockItem.Get(TEMPITEMSUB."Substitute No.");
//                     end;
//                     TEMPITEMSUB."Substitute No." := NonStockItem."Item No."
//                 end;
//             end;

//         end;
//     end;
// }

