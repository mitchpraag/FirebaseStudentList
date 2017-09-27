//
//  studentController .swift
//  FirebaseStudentList
//
//  Created by Mitch Praag on 7/27/17.
//  Copyright © 2017 Mitch Praag. All rights reserved.
//

import Foundation


class StudentController {
    
    static let baseUrl = URL(string: "https://networking-101-41aca.firebaseio.com/students/")
    
    
    static let shared = StudentController()
    
    var students: [Student] = []
    
    
    //This is a change
    
    
   func createStudent (name: String, completion: @escaping (_ student: Student?) -> Void) {
    
      let newStudent = Student(name: name, id: UUID().uuidString)
        
         guard let studentIdURL = StudentController.baseUrl?.appendingPathComponent(newStudent.id).appendingPathComponent(".json") else
         { completion(nil); return }
        
        NetworkController.performRequest(for: studentIdURL, httpMethod: .Put, urlParameters: nil, body: newStudent.jsonData) { (data: Data?, error: Error?) in
            var student: Student? = nil
            
            defer { completion(student) }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                
                
            } else {
                print("successfully saved data to endpoint.")
                
                self.students.append(newStudent)
                student = newStudent
            }
            }
            
        }
    
    
    func fetchStudents(completion: @escaping (_ success: Bool) -> Void) {
        
        guard let allStudentsURL = StudentController.baseUrl?.appendingPathComponent(".json") else { completion(false); return }
        
        NetworkController.performRequest(for: allStudentsURL, httpMethod: .Get, urlParameters: nil, body: nil) { (data: Data?, error: Error?) in
            
            guard let data = data else { completion(false); return}
            
            guard let studentJson = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String : [String : Any]] else {completion(false); return }
            
            var students = [Student]()
            
            for id in Array(studentJson.keys) {
                if let body = studentJson[id], let student = Student(id: id, json: body) {
                    students.append(student)
                }
                
            }
            
            self.students = students
            completion(true)
            
        }
    }
}



        

    
    
    
    
    

