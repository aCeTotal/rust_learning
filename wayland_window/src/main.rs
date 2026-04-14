use eframe::egui;

struct HelloworldWindow;

impl eframe::App for HelloworldWindow {
    fn ui(&mut self, ui: &mut egui::Ui, _frame: &mut eframe::Frame) {
        ui.heading("Hello world! :)");
    }
}

fn main() -> eframe::Result {
    eframe::run_native(
        "Hello World",
        eframe::NativeOptions::default(),
        Box::new(|_cc| Ok(Box::new(HelloworldWindow))),
    )
}
