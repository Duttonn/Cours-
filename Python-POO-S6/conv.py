import tkinter as tk
from tkinter import Spinbox, messagebox

class Converter:
    def __init__(self, master):
        self.master = master
        self.master.title("Convertisseur")

        self.taux = tk.DoubleVar(value=1.2)
        self.current_direction = "euros_to_dollars"  # Track current conversion direction

        # Euros to Dollars conversion
        self.euros_entry = tk.Entry(master, width=10)
        self.euros_entry.grid(row=0, column=0, padx=5, pady=5)
        self.euros_entry.bind("<Return>", self.to_dollars_event)

        self.euros_label = tk.Label(master, text="€              =>")
        self.euros_label.grid(row=0, column=1, padx=5, pady=5)

        self.dollars_entry = tk.Entry(master, width=10)
        self.dollars_entry.grid(row=0, column=2, padx=5, pady=5)
        self.dollars_entry.bind("<Return>", self.to_euros_event)

        self.dollars_label = tk.Label(master, text="$")
        self.dollars_label.grid(row=0, column=3, padx=5, pady=5)

        # Exchange rate
        self.taux_label = tk.Label(master, text="TAUX: 1 € =")
        self.taux_label.grid(row=1, column=0, padx=5, pady=5, sticky="e")

        vcmd = (master.register(self.validate_taux), '%P')
        self.taux_spinbox = Spinbox(master, from_=0.1, to=10.0, increment=0.1, textvariable=self.taux, width=8, validate='all', validatecommand=vcmd)
        self.taux_spinbox.grid(row=1, column=1, padx=5, pady=5)
        self.taux_spinbox.bind("<KeyRelease>", self.update_conversion)
        self.taux_spinbox.bind("<ButtonPress-1>", self.update_conversion)


        self.taux_dollars_label = tk.Label(master, text="$")
        self.taux_dollars_label.grid(row=1, column=2, padx=5, pady=5, sticky="w")

        # Quit button
        self.quit_button = tk.Button(master, text="Quitter", command=master.quit)
        self.quit_button.grid(row=2, column=0, columnspan=4, pady=10)

    def validate_taux(self, new_value):
        try:
            float(new_value)
            self.update_conversion(None)
            return True
        except ValueError:
            return False

    def to_dollars(self, euros):
        try:
            euros = float(euros)
            dollars = euros * self.taux.get()
            self.dollars_entry.delete(0, tk.END)
            self.dollars_entry.insert(0, f"{dollars:.2f}")
            self.euros_label.config(text="€              =>")
            self.current_direction = "euros_to_dollars"
        except ValueError:
            messagebox.showerror("Invalid Input", "Please enter a valid number for Euros.")

    def to_dollars_event(self, event):
        self.to_dollars(self.euros_entry.get())

    def to_euros(self, dollars):
        try:
            dollars = float(dollars)
            euros = dollars / self.taux.get()
            self.euros_entry.delete(0, tk.END)
            self.euros_entry.insert(0, f"{euros:.2f}")
            self.euros_label.config(text="€              <=")
            self.current_direction = "dollars_to_euros"
        except ValueError:
            messagebox.showerror("Invalid Input", "Please enter a valid number for Dollars.")

    def to_euros_event(self, event):
        self.to_euros(self.dollars_entry.get())

    def update_conversion(self, event):
        try:
            self.update_taux()  # Ensure the rate is updated
            if self.current_direction == "euros_to_dollars":
                if self.euros_entry.get():
                    self.to_dollars(self.euros_entry.get())
            elif self.current_direction == "dollars_to_euros":
                if self.dollars_entry.get():
                    self.to_euros(self.dollars_entry.get())
        except ValueError:
            messagebox.showerror("Invalid Input", "Please enter a valid number for the exchange rate.")

    def update_taux(self):
        try:
            self.taux.set(float(self.taux_spinbox.get()))
      #   except ValueError as e:
      #       messagebox.showinfo("Error",str(e))
        except ValueError:
            messagebox.showerror("Invalid Input", "Please enter a valid number for the exchange rate.")

def main():
    root = tk.Tk()
    converter = Converter(root)
    root.mainloop()

if __name__ == "__main__":
    main()
