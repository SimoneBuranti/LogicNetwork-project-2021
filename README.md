# Image Equalization Hardware Component (VHDL)

This repository contains the implementation of a **hardware component in VHDL** developed as the final project for the *Logic Networks* course (A.Y. 2020/2021, Prof. W. Fornaciari).  
The project received a final evaluation of **30/30**.

---

## 📖 Project Overview

The goal of the project was to design and implement a hardware component capable of processing grayscale images (up to **128×128 pixels**) and outputting the **equalized version** of the image.  

The algorithm implemented is a simplified version of **histogram equalization**, a classical image processing technique used to enhance contrast by redistributing pixel intensity values across the available tonal range.

---

## ⚙️ Specifications

- **Input:** Grayscale images with 256 intensity levels.  
- **Output:** Equalized grayscale images with improved contrast.  
- **Constraints:**  
  - Maximum image size: 128 × 128  
  - Supports sequential processing of multiple images  
  - Requires reset only at startup  
- **Algorithm steps:**  
  1. Compute tonal range: `DELTA_VALUE = MAX_PIXEL_VALUE – MIN_PIXEL_VALUE`  
  2. Compute scaling factor: `SHIFT_LEVEL = (8 – floor(log2(DELTA_VALUE+1))))`  
  3. Scale each pixel: `TEMP_PIXEL = (CURRENT_PIXEL – MIN_PIXEL_VALUE) << SHIFT_LEVEL`  
  4. Clamp to maximum: `NEW_PIXEL = min(255, TEMP_PIXEL)`  

---

## 🏗️ Design

The hardware component is structured into two main parts:

- **Datapath**: Performs the actual computation of min, max, scaling factor, and pixel transformation.  
- **Finite State Machine (FSM)**: A **Moore machine with 27 states** that coordinates datapath operations and memory interactions.  

The FSM handles:  
- Reading image dimensions  
- Computing image size  
- Finding min/max intensity values  
- Calculating shift factor  
- Performing the pixel equalization and writing results back to memory  

---

## 🧪 Testing

A comprehensive set of **testbenches** was developed to verify correctness and robustness, including:

- **Corner cases**:  
  - 0 pixels (empty image)  
  - Single pixel image  
  - All pixels = 0  
  - All pixels = 255  
  - Asynchronous reset during computation  

- **Stress tests**:  
  - Maximum size image (128×128)  
  - Sequential image processing  
  - Large batch of 10,000 random test cases  

Results showed that the component was stable, reliable, and passed both **behavioral** and **post-synthesis functional simulations**.

---

## 📊 Results

- Achieved correct functionality across all specified test cases.  
- **Maximum operating frequency**: ~198 MHz (derived from post-synthesis timing analysis).  
- Performance obtained thanks to design choices that minimized datapath critical paths while slightly increasing register usage.  

---

## 📚 Technologies Used

- **VHDL** for hardware description  
- **Xilinx Vivado** for simulation, synthesis, and analysis  
- **ModelSim** for waveform-based verification  

---

## 👥 Authors

- **Simone Buranti**  
- **Alessandro Bagnacani**