// MPDServer.swift
// Copyright (c) 2016 Nyx0uf ( https://mpdremote.whine.io )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import Foundation


final class MPDServer : NSObject, NSCoding
{
	// MARK: - Properties
	// Server name
	var name: String
	// Server IP / hostname
	var hostname: String
	// Server port
	var port: UInt16
	// Server password
	var password: String = ""
	// HTTP url for covers
	var coverURL: String = ""
	// Name of the cover files
	var coverName: String = "cover.jpg"

	// MARK: - Initializers
	init(name: String, hostname: String, port: UInt16)
	{
		self.name = name
		self.hostname = hostname
		self.port = port
	}

	convenience init(name: String, hostname: String, port: UInt16, password: String)
	{
		self.init(name:name, hostname:hostname, port:port)
		self.password = password
	}

	convenience init(name: String, hostname: String, port: UInt16, password: String, coverName: String)
	{
		self.init(name:name, hostname:hostname, port:port, password:password)
		self.coverName = coverName
	}

	convenience init(name: String, hostname: String, port: UInt16, password: String, coverName: String, coverURL: String)
	{
		self.init(name:name, hostname:hostname, port:port, password:password, coverName:coverName)
		self.coverURL = coverURL
	}

	// MARK: - NSCoding
	required convenience init?(coder decoder: NSCoder)
	{
		guard let name = decoder.decodeObjectForKey("name") as? String,
			let hostname = decoder.decodeObjectForKey("hostname") as? String,
			let password = decoder.decodeObjectForKey("password") as? String,
			let coverURL = decoder.decodeObjectForKey("coverurl") as? String,
			let coverName = decoder.decodeObjectForKey("covername") as? String
			else { return nil }
		
		self.init(name:name, hostname:hostname, port:UInt16(decoder.decodeIntegerForKey("port")), password:password, coverName:coverName, coverURL:coverURL)
	}

	func encodeWithCoder(coder: NSCoder)
	{
		coder.encodeObject(self.name, forKey:"name")
		coder.encodeObject(self.hostname, forKey:"hostname")
		coder.encodeInteger(Int(self.port), forKey:"port")
		coder.encodeObject(self.password, forKey:"password")
		coder.encodeObject(self.coverURL, forKey:"coverurl")
		coder.encodeObject(self.coverName, forKey:"covername")
	}
}
